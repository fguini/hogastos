import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/color_helper.dart';

class _GroupedItems {
  final Category category;
  final List<Item> items;
  double total;

  _GroupedItems(this.category, this.items, { this.total = 0 });
}


class HomeBankMovementsGroupedList extends StatelessWidget {
  late List<_GroupedItems> _items;

  HomeBankMovementsGroupedList({ super.key, required List<Item> items }) {
    _items = _getGroupedItems(items);
  }

  List<_GroupedItems> _getGroupedItems(List<Item> items) {
    List<_GroupedItems> groupedItems = [];

    for (var item in items) {
      var groupedCategory = groupedItems.where(
        (groupedItem) => groupedItem.category.id == item.category.id
      ).firstOrNull;
      if(groupedCategory != null) {
        groupedCategory.items.add(item);
        groupedCategory.total += item.amount;
      } else {
        groupedItems.add(
          _GroupedItems(item.category, [item], total: item.amount)
        );
      }
    }

    return groupedItems;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (_, index) {
          var item = _items[index];
          var textColor = getTextColor(item.category.color);

          return Column(
            children: [
              Card(
                color: item.category.color,
                child: ListTile(
                  title: BodyText(
                    item.category.description,
                    color: textColor,
                  ),
                  trailing: BodyText(
                    AppLocalizations.of(context)!.amountCurrency(item.total),
                    color: textColor,
                  ),
                ),
              ),
              ...item.items.map((childItem) => ListTile(
                dense: true,
                title: BodyText(childItem.text),
                trailing: BodyText(
                  AppLocalizations.of(context)!.amountCurrency(childItem.amount),
                ),
              )),
            ],
          );
        },
      ),
    );
  }
}
