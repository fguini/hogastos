import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' as material;
import 'package:hogastos/configurations/authentication.dart';
import 'package:hogastos/configurations/hogastos_icons/hostastos_icon.dart';
import 'package:hogastos/models/movement_type.dart';
import 'package:hogastos/services/data/column_types/color_column.dart';
import 'package:hogastos/services/data/column_types/hogastos_icon_column.dart';
import 'package:hogastos/services/data/column_types/movement_type_column.dart';

import 'migrations/run_migrations.dart';
import 'tables/category_table.dart' as category_table;
import 'tables/movement_table.dart' as movement_table;

part 'db.g.dart';

String _getDbName() {
  var userToken = AuthState().getUser()?.token;

  if(userToken == null) {
    throw Exception('Cannot open database if not authenticated');
  }

  return 'hogastos_db_$userToken';
}

@DriftDatabase(
  tables: [
    category_table.Category,
    movement_table.Movement,
  ]
)
class Db extends _$Db {
  static QueryExecutor _openConnection() {
    return driftDatabase(name: _getDbName());
  }

  Db() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: runUpdateMigrations,
    );
  }
}