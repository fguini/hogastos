import 'package:drift/drift.dart';
import 'package:hogastos/models/movement_type.dart';

class MovementTypeColumn implements CustomSqlType<MovementType> {
  const MovementTypeColumn();

  @override
  String mapToSqlLiteral(MovementType dartValue) => dartValue.name;

  @override
  Object mapToSqlParameter(MovementType dartValue) => dartValue;

  @override
  MovementType read(Object fromSql) => fromSql as MovementType;

  @override
  String sqlTypeName(GenerationContext context) => 'MovementType';
}