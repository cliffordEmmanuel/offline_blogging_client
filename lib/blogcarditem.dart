//this will display a single blog item as a card. It should contain:
// the blog title on top
// an except of the blog body (standard 256 characters)
// an image
// created at timestamp below...

import 'package:flutter/material.dart';
import 'blog.dart';
import 'blogdetails.dart';


enum Item { view, edit, delete }

class BlogCardItem extends StatelessWidget {
  final Blog? blog;
  final VoidCallback onDelete;
  final BuildContext context;

  const BlogCardItem({Key? key, this.blog, required this.onDelete, required this.context}) : super(key: key);


  //handling when i menu item is selected!!
  void _handleMenuItemSelected(BuildContext context, Item item, Blog blog, ) {
    switch (item) {
      case Item.view:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BlogDetails(blog: blog),
        ),
        );

        break;
      case Item.edit:
        print('Edit here!!');
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
              formatTimeElapsed(blog.createdDate),
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.grey),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_horiz),
              onSelected: (value) => _handleMenuItemSelected(context, value, blog),
              itemBuilder: (context) => [
                const PopupMenuItem<Item>(value: Item.view, child: Text('View')),
                const PopupMenuItem<Item>(value: Item.edit, child: Text('Edit')),
                const PopupMenuItem<Item>(value: Item.delete, child: Text('Delete')),
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
                      ? "${blog.title.substring(0, 30)}..."
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
                  blog.blogBody,
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
        SizedBox(
          width: 70,
          height: 70,
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(8), // specifying a bounded rectangle
            child: Image.network(
              blog.imageURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }

  Widget _itemFooter(Blog blog) {
    //will fix later!!!!
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Checkbox(
          checkColor: Colors.white,
          fillColor:
              MaterialStateProperty.resolveWith((states) => Colors.green),
          value: true,
          onChanged: (bool? value) {
            print("blog view");
            // setState(() {
            //   value=false;
            // });
          },
        ),
      ],
    );
  }
}

//
// ///////////////////////////////////
// //building a popupmenu
//
// // This is the type used by the popup menu below.
//
// class PopupMenu extends StatefulWidget {
//   final List<PopupMenuItem<Item>> items;
//
//   const PopupMenu({Key? key, required this.items}) : super(key: key);
//
//   @override
//   State<PopupMenu> createState() => _PopupMenuState();
// }
//
// class _PopupMenuState extends State<PopupMenu> {
//   Item? selectedItem;
//
//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<Item>(
//       initialValue: selectedItem,
//       onSelected: (Item item) {
//         setState(() {
//           selectedItem = item;
//         });
//       },
//       itemBuilder: (BuildContext context) => widget.items,
//     );
//   }
// }
