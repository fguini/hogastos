import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/items_by_category.dart';
import 'package:hogastos/components/common/rounded_list_tile.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/date_helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeBankMovementsSimpleList extends StatelessWidget {
  final List<ItemsByCategory> items;
  final bool isLoading;

  const HomeBankMovementsSimpleList({
    super.key,
    required this.items,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (_, index) {
            var item = items[index];
            var textColor = getTextColor(item.category.color);

            return Column(
              children: [
                RoundedListTile(
                  backgroundColor: item.category.color,
                  textColor: textColor,
                  title: item.category.description,
                  leading: Icon(
                    item.category.icon,
                  ),
                  trailing: BodyText(
                    AppLocalizations.of(context)!.amountCurrency(item.total),
                    color: textColor,
                  ),
                ),
                ...item.items.map((childItem) => RoundedListTile(
                  title: childItem.text,
                  subtitle: getFormattedDate(childItem.date),
                  trailing: BodyText(
                    AppLocalizations.of(context)!.amountCurrency(childItem.amount),
                  ),
                  withCard: false,
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}
