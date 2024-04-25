import 'package:flutter/material.dart';
import 'blog.dart';
import 'bloglist.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Blogging Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: BlogPage(),
    );
  }
}

class BlogPage extends StatefulWidget {
  BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<Blog>? createdBlogsList;
  List<Blog>? deletedBlogsList;
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    createdBlogsList = <Blog>[];
    deletedBlogsList = <Blog>[];
    createdBlogsList?.addAll(createdBlogs);
    deletedBlogsList?.addAll(deletedBlogs);
  }

  void _incrementCounter() {
    print("New post created!!");
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    const String appTitle = "Offline Blogging Client";

    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
       //maybe i'll just have the deleted as a tab
       body: Container(
         child: BlogsList(
               title: "published",
               blogs: createdBlogsList,
             ),
         ),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: "Create new post",
          child: const Icon(Icons.add),
        ),


    );
  }
}
