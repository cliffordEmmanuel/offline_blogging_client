//this will display a single blog item as a card. It should contain:
// the blog title on top
// an except of the blog body (standard 256 characters)
// an image
// created at timestamp below...

import 'package:flutter/material.dart';
import 'blog.dart';

class BlogCardItem extends StatelessWidget {
  final Blog? blog;

  const BlogCardItem({Key? key, this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      key: ValueKey(blog?.uuid),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            _itemHeader(blog!),
            SizedBox(height: 8),
            _itemBody(blog!),
            // SizedBox(height: 8),
            _itemFooter(blog!)
          ],
        ),
      ),
    );
  }

  Widget _itemHeader(Blog blog) {
    return Text(
      _formatTimeElapsed(blog.createdDate),
      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
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
                style: TextStyle(fontWeight: FontWeight.bold ),
              ),
              SizedBox(
                height: 8,
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
          width: 100,
          height: 100,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        TextButton(
          onPressed: () {
            print("blog view");
          },
          child: Text("View"),
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
