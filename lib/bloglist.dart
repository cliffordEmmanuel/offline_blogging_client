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
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: blogs?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final blog = blogs![index];
            return BlogCardItem(blog: blog);
          }),
    );
  }
}
