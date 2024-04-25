// This class is for a specific blog item.
// It must have the following fields:
// Title
// Date of blog item entry
// Main blog item body text
// Image

import 'dart:math';

class Blog {
  final String uuid;
  final String title;
  final DateTime createdDate;
  final DateTime? editedAt;
  final String blogBody;
  final String imageURL;

  Blog({
    required this.uuid,
    required this.title,
    required this.createdDate,
    this.editedAt,
    required this.blogBody,
    required this.imageURL,
  });
}


class UUID {
  final Random _rng;
  UUID() : _rng = Random();
  String generate() =>
      (_rng.nextDouble() * 1e16).toInt().toRadixString(16).padRight(14, '0');
}
