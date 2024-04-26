// this will define a class that returns a list of blog card items
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline_blogging_client/data.dart';

import 'blog.dart';
import 'blogcarditem.dart';

class BlogsList extends StatefulWidget {
  final String? title;
  final List<Blog>? blogs;
  final List<Blog>? deleted;

  const BlogsList({Key? key, this.title, this.blogs, this.deleted})
      : super(key: key);

  @override
  State<BlogsList> createState() => _BlogsListState();
}

class _BlogsListState extends State<BlogsList> {
  void _handleDeleteBlog(Blog blog) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete Confirmation'),
              content: Text('Are you sure you want to delete "${blog.title}"?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // 1. Remove from list (potentially update state)
                    setState(() {
                      widget.blogs!.remove(blog); // Modify the original list
                      deletedBlogs.add(blog);
                    });
                    // 2. Delete from storage (implementation needed)
                    // _deleteBlogFromStorage(blog);
                    Navigator.pop(context, true); // Close dialog after deletion
                  },
                  child: const Text('Delete'),
                ),
              ],
            ));
  }

  // use a list view builder to return each blog item..

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: widget.blogs?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final blog = widget.blogs![index];
            return BlogCardItem(
              context: context,
              blog: blog,
              onDelete: () => _handleDeleteBlog(blog),
            );
          }),
    );
  }
}
