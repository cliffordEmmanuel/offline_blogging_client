import 'package:flutter/material.dart';
import 'blog.dart';

class BlogView extends StatelessWidget {
  final Blog blog;

  const BlogView({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text(blog.title),
          ),
      body: SingleChildScrollView(
        // Allow scrolling for long content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display blog title and date
              _buildTitleAndTimestamp(blog),
              const SizedBox(height: 10),
              // Display blog image (if available)
              // _buildImageSection(blog),
              const SizedBox(height: 20),
              // Display blog content
              _buildBodySection(blog)
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_sharp),
      ),
    );
  }

  // Widget _buildImageSection(Blog blog) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 20, right: 20),
  //   //   child: ClipRRect(
  //   //     // borderRadius: BorderRadius.(8),
  //   //     child: Image.network(
  //   //       // blog.imageURL,
  //   //       fit: BoxFit.cover,
  //   //       width: 600,
  //   //       height: 240,
  //   //     ),
  //   //   ),
  //   );
  // }

  Widget _buildTitleAndTimestamp(Blog blog) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              blog.title,
              softWrap: true,
              maxLines: null,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "posted: ${formatTimeElapsed(blog.createdDate)}",
            style: const TextStyle(
                fontStyle: FontStyle.italic, fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBodySection(Blog blog) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        blog.blogContent,
        softWrap: true,
        style: const TextStyle(
            fontWeight: FontWeight.normal, fontSize: 12, color: Colors.grey),
      ),
    );
  }
}
