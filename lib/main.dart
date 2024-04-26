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
      title: 'Blogging Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: BlogPage(),
    );
  }
}

// Blog page should have a search bar....
class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List<Blog>? createdBlogsList;
  List<Blog>? deletedBlogsList;

  @override
  void initState() {
    super.initState();

    createdBlogsList = <Blog>[];
    deletedBlogsList = <Blog>[];
    createdBlogsList?.addAll(createdBlogs);
    deletedBlogsList?.addAll(deletedBlogs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_outlined),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SearchResult(createdBlogsList),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: BlogsList(
              title: "published",
              blogs: createdBlogsList,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Button clicked");
        },
        tooltip: "Create new post",
        child: const Icon(Icons.add),
      ),
    );
  }
}

// For handling the search results
class SearchResult extends SearchDelegate {
  List<Blog>? blogsList;

  SearchResult(this.blogsList);

  // a generic search method
  List<Blog> searchBlogs(String query) {
    List<Blog> matchQuery = [];
    for (var blog in blogsList!) {
      if (blog.title.toLowerCase().contains(query.toLowerCase()) ||
          blog.blogBody.toLowerCase().contains(query.toLowerCase())) {
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
        child: Text('No matching posts found!'),
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
        child: Text('No suggested posts found!'),
      );
    }
    return BlogsList(
      blogs: matchQuery,
    );
  }
}

// Posts Section !!!
// class FirstSection extends StatelessWidget {
//   const FirstSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text('Posts'),
//         IconButton(
//
//         )
//       ],
//     );
//   }
// }
