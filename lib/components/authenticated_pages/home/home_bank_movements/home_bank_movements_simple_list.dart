import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements.dart';
import 'package:hogastos/components/texts/body_text.dart';

class HomeBankMovementsSimpleList extends StatelessWidget {
  final List<Item> items;

  const HomeBankMovementsSimpleList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          var item = items[index];

          return Card(
            child: ListTile(
              title: BodyText(item.text),
              leading: SizedBox(
                width: 10,
                height: 10,
                child: ColoredBox(color: item.category.color),
              ),
              trailing: BodyText(
                AppLocalizations.of(context)!.amountCurrency(item.amount),
              ),
            ),
          );
        },
      ),
    );
  }
}
