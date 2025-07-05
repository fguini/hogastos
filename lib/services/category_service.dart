import 'package:drift/drift.dart';
import 'package:hogastos/helpers/color_helper.dart';
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

  Future<List<Category>> getByIds(List<int> ids) async {
    var query = db.select(db.category)..where((c) => c.id.isIn(ids));

    var rows = await query.get();

    return rows.map(mapFromSql).toList();
  }

  Future<List<Category>> getAll() async {
    var rows = await db.select(db.category).get();

    return rows.map(mapFromSql).toList();
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

  Future<List<Category>> createCategories(List<CreateCategory> categories) {
    return Future.wait(categories.map(createCategory));
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
  
  Future<Map<String, int>> getUsedColors() async {
    var amountOfColours = db.category.color.count();

    var query = db.selectOnly(db.category)
      ..addColumns([ db.category.color, amountOfColours ])
      ..groupBy([db.category.color]);
    var rows = await query.get();

    Map<String, int> colorsMap = {};

    for (var row in rows) {
      var color = row.read(db.category.color)!;
      var colorId = getColorStringSignature(color);

      colorsMap[colorId] = row.read(amountOfColours) ?? 0;
    }

    return colorsMap;
  }

  Future<Map<String, int>> getUsedIcons() async {
    var amountOfIcons = db.category.icon.count();

    var query = db.selectOnly(db.category)
      ..addColumns([ db.category.icon, amountOfIcons ])
      ..groupBy([db.category.icon]);
    var rows = await query.get();

    Map<String, int> iconsMap = {};

    for (var row in rows) {
      var icon = row.read(db.category.icon)!;

      iconsMap[icon.key] = row.read(amountOfIcons) ?? 0;
    }

    return iconsMap;
  }
}