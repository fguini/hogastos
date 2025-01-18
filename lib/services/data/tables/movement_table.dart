import 'package:drift/drift.dart';
import 'package:hogastos/models/movement_type.dart';
import 'package:hogastos/services/data/column_types/movement_type_column.dart';

import 'category_table.dart';

@DataClassName('Movements')
@TableIndex(name: 'movement_id', columns: {#id})
@TableIndex(name: 'movement_date', columns: {#date})
@TableIndex(name: 'movement_type', columns: {#type})
@TableIndex(name: 'movement_date_type', columns: {#date, #type})
class Movement extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text()();
  IntColumn get categoryId => integer().references(Category, #id)();
  RealColumn get amount => real()();
  Column<MovementType> get type => customType(const MovementTypeColumn())();
}