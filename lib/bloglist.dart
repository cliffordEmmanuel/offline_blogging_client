import 'package:flutter/material.dart';

import 'blog.dart';
import 'blogcarditem.dart';
import 'databasehelper.dart';
import 'blogedit.dart';
import 'blogview.dart';

class BlogsList extends StatefulWidget {
  final String? title;
  final List<Blog>? blogs;
  final VoidCallback? onBlogUpdate;   // to send blog update events back to parent widget

  const BlogsList({
    super.key,
    this.title,
    this.blogs,
    this.onBlogUpdate,
  });

  @override
  State<BlogsList> createState() => _BlogsListState();
}

class _BlogsListState extends State<BlogsList> {
  // use a list view builder to return each blog item..
  void _handleDeleteBlog(Blog blog) {
    final context = this.context;
    // Show the deletion confirmation before
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
                  onPressed: () async {
                    // Delete from database asynchronously
                    await DatabaseHelper.instance
                        .deleteBlog(blog.id!)
                        .then((_) {
                      Navigator.pop(
                          context, true); // Close dialog after deletion
                      // Showing deletion confirmation
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Blog deleted successfully')),
                      );
                      setState(() {
                        widget.blogs!.remove(blog); // Update UI list
                      });
                    });
                  },
                  child: const Text('Delete'),
                ),
              ],
            ));
  }

  void _updateBlogList(Blog editedBlog) {
    widget.onBlogUpdate!();
  }

  void _handleEditBlog(Blog blog) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              EditBlog(blog: blog, onEditComplete: _updateBlogList),
        ));
  }


  void _handleViewBlog(Blog blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogView(blog: blog),
      ),
    );
  }

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
              onView: () => _handleViewBlog(blog),  // receive view trigger from blog card item
              onDelete: () => _handleDeleteBlog(blog), // receive delete trigger from blog card item
              onEdit: () => _handleEditBlog(blog),  // receive delete trigger from blog card item
            );
          }),
    );
  }
}
