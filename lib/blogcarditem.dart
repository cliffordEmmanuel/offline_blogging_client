//this will display a single blog item as a card. It should contain:
// the blog title on top
// an except of the blog body (standard 256 characters)
// an image
// created at timestamp below...

import 'package:flutter/material.dart';
import 'blog.dart';
import 'popup_menu.dart';

class BlogCardItem extends StatelessWidget {
  final Blog? blog;

  const BlogCardItem({Key? key, this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Card(
        key: ValueKey(blog?.uuid),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              _itemHeader(blog!),
              SizedBox(height: 5),
              Flexible(child: _itemBody(blog!)),
              _itemFooter(blog!)
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemHeader(Blog blog) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          _formatTimeElapsed(blog.createdDate),
          style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
        ),
        //may have to create a different class for the popup menu button!
        PopupMenu(items: [
          PopupMenuItem<Item>(value: Item.view, child: Text('view')),
          PopupMenuItem<Item>(value: Item.edit, child: Text('edit')),
          PopupMenuItem<Item>(value: Item.delete, child: Text('delete')),
        ])
      ],
    );
  }

  Widget _itemBody(Blog blog) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // String titleSnippet = blog.title.length >= 100 ? blog.title.substring(0, 100) : blog.title;
              Text(
                blog.title,
                overflow: TextOverflow.fade,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                blog.blogBody,
                // blog.blogBody.length >= 200
                //     ? blog.blogBody.substring(0, 200)
                //     : blog.blogBody,
                softWrap: true,
                maxLines: 2, //
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 8),
        //having a fixed size for the image
        Container(
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
          fillColor: MaterialStateProperty.resolveWith((states) => Colors.green),
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

//displays created timestamp as an
String _formatTimeElapsed(DateTime date) {
  Duration difference = DateTime.now().difference(date);

  if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'Just now';
  }
}

///////////////////////////////////
//building a popupmenu

// This is the type used by the popup menu below.
enum Item { view, edit, delete }

class PopupMenu extends StatefulWidget {
  final List<PopupMenuItem<Item>> items;

  const PopupMenu({Key? key, required this.items}) : super(key: key);

  @override
  State<PopupMenu> createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  Item? selectedItem;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Item>(
      initialValue: selectedItem,
      onSelected: (Item item) {
        setState(() {
          selectedItem = item;
        });
      },
      itemBuilder: (BuildContext context) => widget.items,
    );
  }
}