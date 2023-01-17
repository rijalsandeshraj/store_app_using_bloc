import 'package:flutter/material.dart';

class Category {
  IconData iconData;
  String title;
  bool isSelected;

  Category(this.iconData, this.title, {this.isSelected = false});
}
