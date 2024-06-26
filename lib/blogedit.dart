import 'package:flutter/material.dart';


import 'blog.dart';
import 'databasehelper.dart';

class EditBlog extends StatefulWidget {
  final Blog? blog;
  final Function(Blog)?
      onEditComplete; // this is to pass edit events back to bloglist onCreateComplete
  final VoidCallback?
      onCreateComplete; // to emit creation events back to bloglist...

  EditBlog({
    super.key,
    this.blog,
    this.onEditComplete,
    this.onCreateComplete,
  });

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _content = "";
  bool _isNewBlog = false; // Flag to indicate creating a new blog


  @override
  void initState() {
    super.initState();
    // helps to switch between a create or an update blog action..
    _isNewBlog = widget.blog == null;
    if (_isNewBlog) {
      _title = "";
      _content = "";
    } else {
      _title = widget.blog!.title;
      _content = widget.blog!.blogContent;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(_isNewBlog ? 'Create New Blog' : 'Edit Blog'),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _isNewBlog ? _createBlog() : _updateBlog();
              }
            },
            child: Text(
              _isNewBlog ? 'Publish' : 'Update',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  color: Colors.blueGrey[30],
                  padding: EdgeInsets.all(4.0),
                  child: TextFormField(
                    initialValue: _title,
                    decoration: const InputDecoration(
                      hintText: "Add title...",
                      border: InputBorder.none,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue), // Your desired color
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Add title...';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => _title = value),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  color: Colors.blueGrey[30],
                  padding: EdgeInsets.all(4.0),
                  // height:
                  child: TextFormField(
                    initialValue: _content,
                    decoration: const InputDecoration(
                        hintText: "Write something...",
                        border: InputBorder.none),
                    maxLines: null,
                    // Allow multiple lines
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Write something...';
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => _content = value),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateBlog() async {
    Blog edited = Blog(
      id: widget.blog?.id,
      uuid: widget.blog!.uuid,
      title: _title,
      blogContent: _content,
      createdDate: widget.blog!.createdDate,
      editedAt: DateTime.now(),
    );

    // Call DatabaseHelper to update blog
    await DatabaseHelper.instance.updateBlog(edited);

    if (!mounted) return;

    // Show success message and potentially navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Blog updated successfully!')),
    );

    widget.onEditComplete!(
        edited); // making sure call function is triggered only after edits are done!!

    Navigator.pop(context); // navigate back!!
  }

  void _createBlog() async {
    // Create a new blog
    Blog newBlog = Blog(
      uuid: UUID().generate(),
      title: _title,
      blogContent: _content,
      createdDate: DateTime.now(),
      editedAt: null,
      // imageData: encodeImage(widget.selectedImage!),
    );

    await DatabaseHelper.instance.insertBlog(newBlog);

    if (!mounted) return; // check if widget is still mounted!!

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Blog created successfully!')),
    );

    widget
        .onCreateComplete!(); // making sure callback! function is triggered only after new blog is created are done!!

    Navigator.pop(context);
  }
}
