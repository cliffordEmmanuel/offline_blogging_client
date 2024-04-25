// this will define a class that returns a list of blog card items
import 'package:flutter/cupertino.dart';

import 'blog.dart';
import 'blogcarditem.dart';

class BlogsList extends StatelessWidget {
  final String? title;
  final List<Blog>? blogs;

  const BlogsList({Key? key, this.title, this.blogs}) : super(key: key);

  // use a list view builder to return each blog item..

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(title!),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: blogs?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                final blog = blogs![index];
                print(blog.title);
                return BlogCardItem(blog: blog);
              }),
        ),
      ],
    );
  }
}
