import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';

class ItemsByCategory {
  final Category category;
  final List<Item> items;
  double total;

  ItemsByCategory(this.category, this.items, { this.total = 0 });

  static List<ItemsByCategory> getItemsByCategory(List<Item> items) {
    List<ItemsByCategory> groupedItems = [];

    for (var item in items) {
      var groupedCategory = groupedItems.where(
        (groupedItem) => groupedItem.category.id == item.category.id
      ).firstOrNull;

      if(groupedCategory != null) {
        groupedCategory.items.add(item);
        groupedCategory.total += item.amount;
      } else {
        groupedItems.add(
          ItemsByCategory(item.category, [item], total: item.amount),
        );
      }
    }

    return groupedItems;
  }
}
