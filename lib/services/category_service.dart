import 'package:drift/drift.dart';
import 'package:hogastos/models/category.dart';
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

  Future<List<Category>> getCategoriesByDescription(String? description) async {
    var query = db.select(db.category)..where((c) => c.description.contains(description ?? ''));
    var rows = await query.get();

    return rows.map(mapFromSql).toList();
  }
}