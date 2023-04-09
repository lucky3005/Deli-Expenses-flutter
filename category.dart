import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  //{this.color = Colors.red} this is the default color for the category box
  //which is present in dummy_data.dart

  Category(this.id, this.title, {this.color = Colors.red});
}
