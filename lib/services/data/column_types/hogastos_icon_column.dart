import 'package:drift/drift.dart';
import 'package:hogastos/configurations/hogastos_icons/hostastos_icon.dart';

class HogastosIconColumn implements CustomSqlType<HogastosIcon> {
  const HogastosIconColumn();

  String _iconDataToString(HogastosIcon icon) => icon.key;

  HogastosIcon _stringToHogastosIcon(String sqlValue) {
    return HogastosIcons.values.firstWhere(
      (icon) => icon.key == sqlValue,
      orElse: () => HogastosIcons.placeholder
    );
  }

  @override
  String mapToSqlLiteral(HogastosIcon dartValue) => _iconDataToString(dartValue);

  @override
  Object mapToSqlParameter(HogastosIcon dartValue) => _iconDataToString(dartValue);

  @override
  HogastosIcon read(Object fromSql) => _stringToHogastosIcon(fromSql as String);

  @override
  String sqlTypeName(GenerationContext context) => 'HogastosIcon';
}