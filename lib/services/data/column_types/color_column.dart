import 'dart:ui';

import 'package:drift/drift.dart';
import 'package:hogastos/helpers/color_helper.dart';

class ColorColumn implements CustomSqlType<Color> {
  const ColorColumn();

  Color _stringToColor(String sqlValue) {
    var [
      a,
      b,
      g,
      r,
      colorSpaceName
    ] = sqlValue.split('-');

    return Color.from(
      alpha: double.parse(a),
      red: double.parse(r),
      green: double.parse(g),
      blue: double.parse(b),
      colorSpace: ColorSpace.values.firstWhere((cs) => cs.name == colorSpaceName),
    );
  }

  @override
  String mapToSqlLiteral(Color dartValue) => getColorStringSignature(dartValue);

  @override
  Object mapToSqlParameter(Color dartValue) => getColorStringSignature(dartValue);

  @override
  Color read(Object fromSql) => _stringToColor(fromSql as String);

  @override
  String sqlTypeName(GenerationContext context) => 'Color';
}