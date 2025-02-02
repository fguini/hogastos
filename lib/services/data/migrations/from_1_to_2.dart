import 'package:drift/drift.dart';

import '../db_connect.dart';

Future<void> migrateFrom1To2(Migrator m) async {
  var db = DbConnect().db;

  await m.addColumn(db.category, db.category.deletedAt);
}