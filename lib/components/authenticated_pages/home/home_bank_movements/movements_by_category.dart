import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/movement.dart';

class MovementsByCategory {
  final Category category;
  final List<Movement> movements;
  double total;

  MovementsByCategory(this.category, this.movements, { this.total = 0 });

  static List<MovementsByCategory> getMovementsByCategory(List<Movement> movements) {
    List<MovementsByCategory> groupedItems = [];

    for (var movement in movements) {
      var groupedCategory = groupedItems.where(
        (groupedItem) => groupedItem.category.id == movement.category.id
      ).firstOrNull;

      if(groupedCategory != null) {
        groupedCategory.movements.add(movement);
        groupedCategory.total += movement.amount;
      } else {
        groupedItems.add(
          MovementsByCategory(movement.category, [movement], total: movement.amount),
        );
      }
    }

    return groupedItems;
  }
}
