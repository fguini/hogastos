import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/movements_by_category.dart';
import 'package:hogastos/components/common/rounded_list_tile.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeBankMovementsGroupedList extends StatelessWidget {
  final List<MovementsByCategory> movements;
  final bool isLoading;

  const HomeBankMovementsGroupedList({
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
            var categoryColor = item.category.color;

            var backgroundColor = categoryColor.withValues(alpha: 0.2);

            return RoundedListTile(
              backgroundColor: backgroundColor,
              title: item.category.description,
              subtitle: AppLocalizations.of(context)!.movementsCount(
                  item.movements.length
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
      ),
    );
  }
}
