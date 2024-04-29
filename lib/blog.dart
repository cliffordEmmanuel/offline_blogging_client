// This class is for a specific blog item.
// It must have the following fields:
// Title
// Date of blog item entry
// Main blog item body text
// Image

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'dart:async';


class Blog {
  final int? id; // this is for the database!!
  String uuid;
  String title;
  DateTime createdDate;
  DateTime? editedAt;
  String blogContent;


  Blog({
    this.id,
    required this.uuid,
    required this.title,
    required this.createdDate,
    this.editedAt,
    required this.blogContent,
  });


  // Since we're working with sqf lite for persisting the blog data
  // Methods for converting a blog object to a map and vice versa are needed
  // to bridge the gap between the blog data structure and the format
  // that is required by the database.


  // For the conversion of a blog object to map
  Map<String, dynamic> toMap() => {
    'id': id,
    'uuid': uuid,
    'title': title,
    'blogContent': blogContent,
    'created_date': createdDate.toIso8601String(),
    'edited_at': editedAt?.toIso8601String(),
    // 'image_url': imageURL,
  };

  // For the conversion of blog object from a Map for database retrieval
  factory Blog.fromMap(Map<String, dynamic> map) => Blog (
    id: map['id'] as int,
    uuid: map['uuid'] as String,
    title: map['title'] as String,
    blogContent: map['blogContent'] as String,
    createdDate: DateTime.parse(map['created_date'] as String),
    editedAt: map['edited_at'] != null ? DateTime.parse(map['edited_at'] as String) : null,
    // imageURL: map['image_url'] as String,
  );


}

// generating a unique id to be attached to each blog item...
class UUID {
  final Random _rng;

  UUID() : _rng = Random();

  String generate() =>
      (_rng.nextDouble() * 1e16).toInt().toRadixString(16).padRight(14, '0');
}

//displays created timestamp in a way that indicates duration from last update..
String formatTimeElapsed(DateTime date) {
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
