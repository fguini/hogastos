import 'package:flutter/material.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/movement.dart';

import 'data/db.dart';

class MovementService {
  Db db = Db();

  Movement _mapFromSql(Movements sql) => Movement(
    sql.description,
    Category(1, 'churrin1', Colors.greenAccent, Icons.church), // TODO get category
    sql.amount,
    sql.date,
    sql.type,
  );

  Future<Movement> getById(int id) async {
    var movement = await (db.select(db.movement)..where((m) => m.id.equals(id))).getSingle();

    return _mapFromSql(movement);
  }


  Future<Movement> createMovement(Movement movement) async {
    var companion = MovementCompanion.insert(
      date: movement.date,
      description: movement.text,
      amount: movement.amount,
      type: movement.type,
    );

    var newId = await db.into(db.movement).insert(companion);

    return getById(newId);
  }
}