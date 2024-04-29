import 'package:flutter/material.dart';

import 'blog.dart';


enum Item { view, edit, delete }

class BlogCardItem extends StatelessWidget {
  final Blog? blog;
  final VoidCallback onView;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final BuildContext context;

  const BlogCardItem(
      {Key? key,
      this.blog,
      required this.onDelete,
      required this.onEdit,
      required this.onView,
      required this.context})
      : super(key: key);

  //handling when i menu item is selected!!
  void _handleMenuItemSelected(
    BuildContext context,
    Item item,
    Blog blog,
  ) {
    switch (item) {
      case Item.view:
        onView();
        break;
      case Item.edit:
        onEdit();
        break;
      case Item.delete:
        onDelete();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        key: ValueKey(blog?.uuid),
        margin: const EdgeInsets.all(5.0),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _itemHeader(blog!),
              SizedBox(height: 5),
              Flexible(child: _itemBody(blog!)),
              // _itemFooter(blog!)
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemHeader(Blog blog) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: SizedBox(
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "posted ${formatTimeElapsed(blog.createdDate)}",
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz),
              onSelected: (value) =>
                  _handleMenuItemSelected(context, value, blog),
              itemBuilder: (context) => [
                const PopupMenuItem<Item>(
                    value: Item.view, child: Text('View')),
                const PopupMenuItem<Item>(
                    value: Item.edit, child: Text('Edit')),
                const PopupMenuItem<Item>(
                    value: Item.delete, child: Text('Delete')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBody(Blog blog) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  blog.title.length > 30
                      ? blog.title.substring(0, 30)
                      : blog.title,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  blog.blogContent,
                  style: TextStyle(color: Colors.grey),
                  softWrap: true,
                  maxLines: 3, //
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // SizedBox(
        //   width: 70,
        //   height: 70,
        //   child: ClipRRect(
        //     borderRadius:
        //         BorderRadius.circular(8), // specifying a bounded rectangle
        //     child: Image.network(
        //       // blog.imageURL,
        //       fit: BoxFit.cover,
        //       errorBuilder: (context, error, stackTrace) {
        //         return const Center(child: Icon(Icons.error)); // Display error icon
        //       },
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
