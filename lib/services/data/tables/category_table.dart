import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:hogastos/configurations/hogastos_icons/hostastos_icon.dart';
import 'package:hogastos/services/data/column_types/color_column.dart';
import 'package:hogastos/services/data/column_types/hogastos_icon_column.dart';

@DataClassName('Categories')
@TableIndex(name: 'category_id', columns: {#id})
@TableIndex(name: 'category_description', columns: {#description})
class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  Column<Color> get color => customType(const ColorColumn())();
  Column<HogastosIcon> get icon => customType(const HogastosIconColumn())();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}