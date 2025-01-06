import 'package:drift/drift.dart';
import 'package:flutter/material.dart';

class IconDataColumn implements CustomSqlType<IconData> {
  const IconDataColumn();

  String _iconDataToString(IconData iconData) => [
    iconData.codePoint.toString(),
    iconData.fontFamily ?? ''
  ].join('-');

  IconData _stringToIconData(String sqlValue) {
    var [
    codePoint,
    fontFamily,
    ] = sqlValue.split('-');

    return IconData(
      int.parse(codePoint),
      fontFamily: fontFamily,
    );
  }

  @override
  String mapToSqlLiteral(IconData dartValue) => _iconDataToString(dartValue);

  @override
  Object mapToSqlParameter(IconData dartValue) => _iconDataToString(dartValue);

  @override
  IconData read(Object fromSql) => _stringToIconData(fromSql as String);

  @override
  String sqlTypeName(GenerationContext context) => 'IconData';
}