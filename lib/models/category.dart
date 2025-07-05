import 'package:flutter/material.dart';
import 'package:hogastos/configurations/hogastos_icons/hostastos_icon.dart';
import 'package:hogastos/models/create_category.dart';

class Category extends CreateCategory {
  final int id;

  Category(
    this.id,
    super.description,
    super.color,
    super.icon,
  );

  factory Category.fromDescription(String description) {
    return Category(
      0,
      description,
      Colors.white60, // TODO this should be normalized
      HogastosIcons.placeholder,
    );
  }
}