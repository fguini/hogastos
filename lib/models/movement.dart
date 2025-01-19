import 'package:hogastos/models/create_movement.dart';

class Movement extends CreateMovement {
  final int id;

  Movement(
    this.id,
    super.text,
    super.category,
    super.amount,
    super.date,
    super.type,
  );
}