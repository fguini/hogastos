import 'package:drift/drift.dart';
import 'package:hogastos/models/movement_type.dart';

class MovementTypeColumn implements CustomSqlType<MovementType> {
  const MovementTypeColumn();

  @override
  String mapToSqlLiteral(MovementType dartValue) => dartValue.name;

  @override
  Object mapToSqlParameter(MovementType dartValue) => dartValue.name;

  @override
  MovementType read(Object fromSql) => MovementType.values.firstWhere((type) => type.name == fromSql.toString());

  @override
  String sqlTypeName(GenerationContext context) => 'MovementType';
}