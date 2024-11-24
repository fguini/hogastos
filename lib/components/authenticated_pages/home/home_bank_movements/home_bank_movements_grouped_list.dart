import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/items_by_category.dart';
import 'package:hogastos/components/common/rounded_list_tile.dart';
import 'package:hogastos/components/texts/body_text.dart';

class HomeBankMovementsGroupedList extends StatelessWidget {
  final List<ItemsByCategory> items;

  const HomeBankMovementsGroupedList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          var item = items[index];
          var categoryColor = item.category.color;

          var backgroundColor = categoryColor.withOpacity(0.2);

          return RoundedListTile(
            backgroundColor: backgroundColor,
            title: item.category.description,
            subtitle: AppLocalizations.of(context)!.movementsCount(
              item.items.length
            ),
            leading: Icon(
              item.category.icon,
            ),
            trailing: BodyText(
              AppLocalizations.of(context)!.amountCurrency(item.total),
            ),
          );
        },
      ),
    );
  }
}
