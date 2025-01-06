import 'package:flutter/material.dart';
import 'package:hogastos/models/category.dart';

var _category1 = Category(1, 'churrin1', Colors.greenAccent, Icons.church);
var _category2 = Category(2, 'churrin2', Colors.purple, Icons.incomplete_circle);
var _category3 = Category(3, 'churrin3', Colors.blueAccent, Icons.local_airport);

class CategoryService {
  List<Category> getCategoriesByDescription(String? description) {
    return [
      _category1,
      _category2,
      _category3,
    ].where(
      (val) => description == null || val.description.contains(description)
    ).toList();
  }
}