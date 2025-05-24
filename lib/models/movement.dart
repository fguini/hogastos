import 'package:hogastos/models/create_movement.dart';

import 'category.dart';
import 'movement_type.dart';

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

  set text(String? newText) {
    text = newText ?? '';
  }

  static Movement textPlusCategory(String text, Category category) => Movement(
    0,
    text,
    category,
    0,
    DateTime.now(),
    MovementType.computable
  );
}