import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/movements_by_category.dart';
import 'package:hogastos/components/common/rounded_list_tile.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/date_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeBankMovementsSimpleList extends StatelessWidget {
  final List<MovementsByCategory> movements;
  final bool isLoading;

  const HomeBankMovementsSimpleList({
    super.key,
    required this.movements,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Skeletonizer(
        enabled: isLoading,
        child: ListView.builder(
          itemCount: movements.length,
          itemBuilder: (_, index) {
            var item = movements[index];
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
                ...item.movements.map((childItem) => RoundedListTile(
                  title: childItem.text,
                  subtitle: getFormattedDate(childItem.date),
                  trailing: BodyText(
                    AppLocalizations.of(context)!.amountCurrency(childItem.amount),
                  ),
                  onTap: () => NavigatorHelper.pushNamed(
                    context,
                    RoutesNames.movementsEdit,
                    arguments: childItem.id
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
