import 'package:drift/drift.dart';
import 'package:hogastos/models/movement.dart';

import 'category_service.dart';
import 'data/db.dart';
import 'data/db_connect.dart';

class MovementService {
  Db db = DbConnect().db;

  Movement _mapFromSql(Movements sqlMovement, Categories sqlCategory) => Movement(
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


  Future<Movement> createMovement(Movement movement) async {
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
}