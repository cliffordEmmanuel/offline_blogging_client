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

//displays created timestamp as an
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

class UUID {
  final Random _rng;
  UUID() : _rng = Random();
  String generate() =>
      (_rng.nextDouble() * 1e16).toInt().toRadixString(16).padRight(14, '0');
}
