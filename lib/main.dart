import 'package:flutter/material.dart';

import 'blog.dart';
import 'bloglist.dart';
import 'databasehelper.dart';
import 'blogedit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blogging Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: BlogPage(),
    );
  }
}


class BlogPage extends StatefulWidget {
  const BlogPage({super.key,});


  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  Future<List<Blog>>? _blogsFuture; // holds blogs to be retrieved from the db

  @override
  void initState() {
    super.initState();
    _blogsFuture = DatabaseHelper.instance.getBlogs();
  }

  void refreshBlogData() {
    // make a db call when a specific event occurs!!
    setState(() {
      _blogsFuture = DatabaseHelper.instance.getBlogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () async { // to make sure db fetch can happen asynchronously
              final blogs = await _blogsFuture; // wait for blogs to arrive

              if (blogs != null) {
                showSearch(
                  context: context,
                  delegate: SearchResult(blogs),
                );
              }
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Using the Future builder to avoid pre-populating the list
          // and rely on the db for the blog data
          FutureBuilder<List<Blog>>(
            future: _blogsFuture,
            builder: (context, snapshot) {
              // if data is available extract it!
              if (snapshot.hasData) {
                final blogs = snapshot.data!;
                blogs.sort((a, b) => b.createdDate.compareTo(a.createdDate)); // sorts by the most recent post
                return Expanded(
                  child: BlogsList(
                    title: "published",
                    blogs: blogs,
                    onBlogUpdate: refreshBlogData, // Inform BlogPage
                  ),

                );
                // display and error message if there's an error
              } else if (snapshot.hasError) {
                return const Center(child: Text("Error fetching blogs"));
              }
              // show loading progress!!
              return const Center(child: CircularProgressIndicator());
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditBlog(onCreateComplete: refreshBlogData,)),
          );
        },
        tooltip: "Create new post",
        child: const Icon(Icons.add),
      ),
    );
  }
}

// This is for the search implementation
class SearchResult extends SearchDelegate {
  List<Blog>? blogsList;

  SearchResult(this.blogsList);

  // a generic search method
  List<Blog> searchBlogs(String query) {
    List<Blog> matchQuery = [];
    for (var blog in blogsList!) {
      if (blog.title.toLowerCase().contains(query.toLowerCase()) ||
          blog.blogContent.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(blog);
      }
    }
    return matchQuery;
  }

  //dynamically changing the search bar behaviour and look depending on what
  // the user is doing at the time

  // when the search bar is active change icon button to clear!!...
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  // when the search is active display an arrow widget to allow the user
  // leave the search interface!!
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  // this returns the search results to be displayed
  @override
  Widget buildResults(BuildContext context) {
    List<Blog> matchQuery = searchBlogs(query);
    if (matchQuery.isEmpty) {
      return const Center(
        child: Text('No posts found!'),
      );
    }
    return BlogsList(
      blogs: matchQuery,
    );
  }

  // this will return suggestions as the user types.
  @override
  Widget buildSuggestions(BuildContext context) {
    List<Blog> matchQuery = searchBlogs(query);
    if (matchQuery.isEmpty) {
      return const Center(
        child: Text('No posts found!'),
      );
    }
    return BlogsList(
      blogs: matchQuery,
    );
  }
}
