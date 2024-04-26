import 'package:flutter/material.dart';
import 'blog.dart';

class BlogDetails extends StatelessWidget {
  final Blog blog;

  const BlogDetails({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleAndTimestamp(blog),
          const SizedBox(height: 20),
          _buildImageSection(blog),
          const SizedBox(height: 8), // Spacing between sections
          _buildBodySection(blog),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                // Adjust padding as needed
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_sharp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection(Blog blog) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: ClipRRect(
        // borderRadius: BorderRadius.(8),
        child: Image.network(
          blog.imageURL,
          fit: BoxFit.cover,
          width: 600,
          height: 240,
        ),
      ),
    );
  }

  Widget _buildTitleAndTimestamp(Blog blog) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            blog.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Text(
            formatTimeElapsed(blog.createdDate),
            style: const TextStyle(
                fontStyle: FontStyle.italic, fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBodySection(Blog blog) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Text(
          blog.blogBody,
          softWrap: true,
          style: const TextStyle(
              fontWeight: FontWeight.normal, fontSize: 12, color: Colors.grey),
        ),
      ),
    );
  }
}
