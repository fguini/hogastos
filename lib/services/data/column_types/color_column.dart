import 'dart:ui';

import 'package:drift/drift.dart';

class ColorColumn implements CustomSqlType<Color> {
  const ColorColumn();

  String _colorToString(Color color) => [
    color.a,
    color.b,
    color.g,
    color.r,
    color.colorSpace.name
  ].join('-');

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
  String mapToSqlLiteral(Color dartValue) => _colorToString(dartValue);

  @override
  Object mapToSqlParameter(Color dartValue) => _colorToString(dartValue);

  @override
  Color read(Object fromSql) => _stringToColor(fromSql as String);

  @override
  String sqlTypeName(GenerationContext context) => 'Color';
}