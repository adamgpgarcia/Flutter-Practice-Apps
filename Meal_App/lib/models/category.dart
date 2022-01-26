import 'package:flutter/material.dart';

//This class was made to color code each of the types of cuisin
class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    @required this.id,
    @required this.title,
    this.color = Colors.orange,
  });
}
