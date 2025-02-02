import 'package:drift/drift.dart';

import 'from_1_to_2.dart';

Future<void> runUpdateMigrations (Migrator m, int from, int to) async {
  if(from == 1) {
    await migrateFrom1To2(m);
  }
}