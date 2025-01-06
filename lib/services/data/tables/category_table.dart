import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:flutter/material.dart' as material;
import 'package:hogastos/services/data/column_types/color_column.dart';
import 'package:hogastos/services/data/column_types/icon_data_column.dart';

@DataClassName('Categories')
@TableIndex(name: 'category_id', columns: {#id})
class Category extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
  Column<Color> get color => customType(const ColorColumn())();
  Column<material.IconData> get icon => customType(const IconDataColumn())();
}