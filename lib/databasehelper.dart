import 'blog.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = "blogs.db";
  static const String _tableName = "blogs";

  // Private constructor to prevent instantiation
  // this uses a singleton instance such that there's one centralized access
  // to database operations...
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // stores the actual reference to teh database
  static Database? _database;

  // this retrieves the database instance
  // first checks if already initialized if not
  // creates one by calling the _initDatabase
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    // using the path package is best practice to ensure that path is correctly
    // constructed for each platform.
    return await openDatabase(
        join(await getDatabasesPath(), _databaseName),
        version: 1, // Database version
        onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uuid TEXT NOT NULL UNIQUE,
            title TEXT NOT NULL,
            blogContent TEXT NOT NULL,
            created_date TEXT NOT NULL,
            edited_at TEXT
          )
          ''');
    });
  }

  // Insert a new blog and return the id of the blog entry
  Future<int> insertBlog(Blog blog) async {
    final db = await database;
    return await db.insert(_tableName, blog.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Doing a batch insert using the transactions from SQLite
  // for efficiency
  Future<void> insertMultipleBlogs(List<Blog> blogs) async {
    final db = await DatabaseHelper.instance.database;
    await db.transaction((txn) async {
      for (final blog in blogs) {
        await txn.insert(_tableName, blog.toMap());
      }
    });
  }

  // Get all stored blogs
  // will be useful for the blogs home page
  Future<List<Blog>> getBlogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) => Blog.fromMap(maps[i]));
  }

  // Get a specific blog by ID
  Future<Blog?> getBlogById(int id) async {
    final db = await database;
    const String orderBy = 'createdDate DESC';
    final List<Map<String, dynamic>> maps = await db.query(_tableName, orderBy: orderBy);
    return maps.isNotEmpty ? Blog.fromMap(maps.first) : null;
  }

  // Update a blog
  Future<int> updateBlog(Blog blog) async {
    final db = await database;
    return await db.update(_tableName, blog.toMap(),
        where: "id = ?", whereArgs: [blog.id]);
  }

  // Delete a blog
  Future<int> deleteBlog(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}


