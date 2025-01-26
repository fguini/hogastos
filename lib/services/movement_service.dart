import 'package:drift/drift.dart';
import 'package:hogastos/models/create_movement.dart';
import 'package:hogastos/models/movement.dart';

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

  Stream<List<Movement>> watchByMonthAndYear(int month, int year) {
    var from = DateTime(year, month, 1);
    var to = DateTime(year, month + 1, 0);

    var query = db.select(db.movement).join([
      innerJoin(db.category, db.category.id.equalsExp(db.movement.categoryId))
    ])..where(db.movement.date.isBetweenValues(from, to));

    return query.watch().map(
      (rows) => rows.map((row) => _mapFromSql(
        row.readTable(db.movement),
        row.readTable(db.category)
      )
    ).toList());
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

  Future<Movement> updateMovement(Movement movement) async {
    var newId = await (
      db.update(db.movement)..where((m) => m.id.equals(movement.id))
    ).write(MovementCompanion(
      date: Value(movement.date),
      description: Value(movement.text),
      categoryId: Value(movement.category.id),
      amount: Value(movement.amount),
      type: Value(movement.type),
    ));

    return getById(newId);
  }
}