import 'category.dart';
import 'movement_type.dart';

class Movement {
  final String text;
  final Category category;
  final double amount;
  final DateTime date;
  final MovementType type;

  Movement(
    this.text,
    this.category,
    this.amount,
    this.date,
    this.type,
  );

  bool get isComputable => type == MovementType.computable;
  bool get isNotComputable => type == MovementType.notComputable || amount == 0;

  bool get isIncome => amount > 0;
  bool get isExpense => amount < 0;

  bool get isComputableIncome => isComputable && isIncome;
  bool get isComputableExpense => isComputable && isExpense;
}