import 'package:drift/drift.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_category.dart';
import 'package:hogastos/services/data/db_connect.dart';

import 'data/db.dart';

class CategoryService {
  Db db = DbConnect().db;

  static Category mapFromSql(Categories sqlCategory) => Category(
    sqlCategory.id,
    sqlCategory.description,
    sqlCategory.color,
    sqlCategory.icon,
  );

  Future<Category> getById(int id) async {
    var query = db.select(db.category)..where((c) => c.id.equals(id));

    var row = await query.getSingle();

    return mapFromSql(row);
  }

  Future<List<Category>> getCategoriesByDescription(String? description, { int limit = 5 }) async {
    var query = db.select(db.category)
      ..limit(limit)
      ..where((c) => c.description.contains(description ?? ''));
    var rows = await query.get();

    return rows.map(mapFromSql).toList();
  }

  Future<bool> existAnyCategory() async {
    var categories = await getCategoriesByDescription(null);

    return categories.isNotEmpty;
  }

  Future<Category> createCategory(CreateCategory category) async {
    var companion = CategoryCompanion.insert(
      description: category.description,
      color: category.color,
      icon: category.icon,
    );

    var newId = await db.into(db.category).insert(companion);

    return getById(newId);
  }
}