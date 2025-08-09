import 'package:drift/drift.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/models/create_movement.dart';
import 'package:hogastos/models/movement.dart';

import '../models/movement_type.dart';
import 'category_service.dart';
import 'data/db.dart';
import 'data/db_connect.dart';

class MovementService {
  Db db = DbConnect().db;

  Movement _mapFromSql(Movements sqlMovement, Categories sqlCategory) => Movement(
    sqlMovement.id,
    sqlMovement.description,
    CategoryService.mapFromSql(sqlCategory),
    sqlMovement.amount,
    sqlMovement.date,
    sqlMovement.type,
  );

  Future<Movement> getById(int id) async {
    var query = db.select(db.movement).join([
      innerJoin(db.category, db.category.id.equalsExp(db.movement.categoryId))
    ])..where(db.movement.id.equals(id));

    var row = await query.getSingle();

    return _mapFromSql(row.readTable(db.movement), row.readTable(db.category));
  }

  Future<int> movementsWithCategoryCount(int categoryId) async {
    final count = db.movement.id.count(distinct: true);
    var query = db.selectOnly(db.movement)
      ..where(db.movement.categoryId.equals(categoryId));

    query.addColumns([count]);

    var countResult = await query.map((row) => row.read(count)).getSingle();

    return countResult ?? 0;
  }

  JoinedSelectStatement<HasResultSet, dynamic> _byMonthAndYearQuery(int month, int year) {
    var from = DateTime(year, month, 1, 0, 0, 0, 0, 0);
    var to = DateTime(year, month + 1, 0, 23, 59, 59, 999);

    return db.select(db.movement).join([
      innerJoin(db.category, db.category.id.equalsExp(db.movement.categoryId))
    ])..where(db.movement.date.isBetweenValues(from, to));

  }

  Future<List<Movement>> getByMonthAndYear(int month, int year) async {
    var query = _byMonthAndYearQuery(month, year);
    var rows = await query.get();

    return rows.map((row) => _mapFromSql(
      row.readTable(db.movement),
      row.readTable(db.category),
    )).toList();
  }

  Stream<List<Movement>> watchByMonthAndYear(int month, int year) {
    var query = _byMonthAndYearQuery(month, year);

    return query.watch().map(
      (rows) => rows.map((row) => _mapFromSql(
        row.readTable(db.movement),
        row.readTable(db.category)
      )
    ).toList());
  }

  Future<List<Movement>> getMovementSuggestions(String? text) async {
    if(text?.isEmpty ?? true) {
      return [];
    }

    final maxAmount = db.movement.amount.max();

    var query = db.selectOnly(db.movement, distinct: true)
      ..addColumns([db.movement.description, db.movement.categoryId, db.movement.type, maxAmount])
      ..limit(5)
      ..where(db.movement.description.contains(text!))
      ..groupBy([db.movement.description, db.movement.categoryId]);

    var rows = await query
      .map((row) => (
        row.read(db.movement.description),
        row.read(db.movement.categoryId),
        row.read(db.movement.type),
        row.read(maxAmount),
      ))
      .get();

    var onlyValidRows = rows
      .where((row) => row.$1 != null && row.$2 != null)
      .map((row) => (row.$1!, row.$2!, row.$3, row.$4));
    var categoriesIds = onlyValidRows.map((row) => row.$2).toList();
    var categories = await CategoryService().getByIds(categoriesIds);

    return onlyValidRows.map((row) => Movement.partialPlusCategory(
      row.$1,
      row.$3 ?? MovementType.computable,
      row.$4 ?? 0,
      categories.firstWhere((c) => c.id == row.$2, orElse: () => categories.first)
    )).toList();
  }

  Future<List<MonthAndYear>> getMovementsMonthAndYear() async {
    var month = db.movement.date.strftime('%m').cast<int>();
    var year = db.movement.date.strftime('%Y').cast<int>();

    var query = db.selectOnly(db.movement, distinct: true)..addColumns([ month, year ]);

    var rows = await query.get();

    return rows
      .map(
        (row) => MonthAndYear.fromMonthAndYear(
          row.read(month)!,
          row.read(year)!
        )
      )
      .toList();
  }

  Future<Movement> createMovement(CreateMovement movement) async {
    var companion = MovementCompanion.insert(
      date: movement.date,
      description: movement.text,
      categoryId: movement.category.id,
      amount: movement.amount,
      type: movement.type,
    );

    var newId = await db.into(db.movement).insert(companion);

    return getById(newId);
  }

  Future<List<Movement>> createMovements(List<CreateMovement> movements) {
    return Future.wait(movements.map(createMovement));
  }

  Future<Movement> updateMovement(Movement movement) async {
    await (
      db.update(db.movement)..where((m) => m.id.equals(movement.id))
    ).write(MovementCompanion(
      date: Value(movement.date),
      description: Value(movement.text),
      categoryId: Value(movement.category.id),
      amount: Value(movement.amount),
      type: Value(movement.type),
    ));

    return getById(movement.id);
  }

  Future<void> updateMovementsCategories(int fromCategoryId, int toCategoryId) async {
    await (
      db.update(db.movement)..where((m) => m.categoryId.equals(fromCategoryId))
    ).write(MovementCompanion(
      categoryId: Value(toCategoryId)
    ));
  }

  Future<Movement> deleteMovement(int movementId) async {
    var movement = await getById(movementId);

    await (db.delete(db.movement)..where((c) => c.id.equals(movementId))).go();

    return movement;
  }
}