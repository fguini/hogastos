import 'package:drift/drift.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_category.dart';
import 'package:hogastos/services/data/db_connect.dart';

import 'data/db.dart';
import 'movement_service.dart';

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
      ..where((c) => c.description.contains(description ?? '') & c.deletedAt.isNull());
    var rows = await query.get();

    return rows.map(mapFromSql).toList();
  }

  Future<bool> existAnyCategory() async {
    var categories = await getCategoriesByDescription(null);

    return categories.isNotEmpty;
  }

  Future<bool> categoryHasMovements(int id) async {
    var movementsCount = await MovementService().movementsWithCategoryCount(id);

    return movementsCount > 0;
  }

  Stream<List<Category>> watchCategories({ String? search }) {
    var query = db.select(db.category)..where((c) => c.deletedAt.isNull());

    if(search?.isNotEmpty ?? false) {
      query = query..where((c) => c.description.contains(search!));
    }

    return query.watch().map(
      (rows) => rows.map(mapFromSql).toList()
    );
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

  Future<Category> updateCategory(Category category) async {
    var newId = await (
      db.update(db.category)..where((c) => c.id.equals(category.id))
    ).write(CategoryCompanion(
      description: Value(category.description),
      color: Value(category.color),
      icon: Value(category.icon),
    ));

    return getById(newId);
  }

  Future<Category> deleteCategory(int categoryId, { int? moveToId }) async {
    var hasMovements = await categoryHasMovements(categoryId);
    var hasMoveToId = moveToId != null;

    if(hasMoveToId && hasMovements) {
      await MovementService().updateMovementsCategories(categoryId, moveToId);
    }

    var category = await getById(categoryId);

    if(!hasMovements || hasMoveToId) {
      await (db.delete(db.category)..where((c) => c.id.equals(categoryId))).go();
    } else {
      await (
        db.update(db.category)..where((c) => c.id.equals(categoryId))
      ).write(
        CategoryCompanion(deletedAt: Value(DateTime.now()))
      );
    }

    return category;
  }
}