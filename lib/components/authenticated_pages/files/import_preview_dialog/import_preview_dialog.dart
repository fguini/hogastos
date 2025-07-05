import 'package:flutter/material.dart';
import 'package:hogastos/components/common/dialog_container.dart';
import 'package:hogastos/components/common/rounded_list_tile.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/hint_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/date_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_movement.dart';

class ImportPreviewDialog extends StatelessWidget {
  final List<Category> categories;
  final List<CreateMovement> movements;
  final VoidCallback onClose;
  final VoidCallback onImport;

  const ImportPreviewDialog({
    super.key,
    required this.categories,
    required this.movements,
    required this.onClose,
    required this.onImport,
  });

  double _getCategoriesHeight(Iterable<Category> newCategories) {
    double categoriesHeight = 60;

    if(newCategories.length > 1) {
      double newCategoriesHeight = newCategories.length * 30;

      categoriesHeight = newCategoriesHeight > 210
        ? 210
        : newCategoriesHeight;
    }

    return categoriesHeight;
  }

  double _getMovementsHeight(Iterable<CreateMovement> movements) {
    double movementsHeight = 100;

    if(movements.length > 1) {
      double newMovementsHeight = movements.length * 100;

      movementsHeight = newMovementsHeight > 400
          ? 400
          : newMovementsHeight;
    }

    return movementsHeight;
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);
    var theme = Theme.of(context);

    var newCategories = categories.where((c) => c.id == 0);

    return DialogContainer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubtitleText(localization.importFromExcelPreviewCategories),
          SizedBox(
            height: _getCategoriesHeight(newCategories),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 10),
              children: newCategories.isEmpty
                ? [ ListTile(title: HintText(localization.importFromExcelPreviewCategoriesEmpty)) ]
                : newCategories.map((category) => RoundedListTile(
                  title: category.description,
                )).toList(),
            ),
          ),
          SubtitleText(localization.importFromExcelPreviewMovements),
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            height: _getMovementsHeight(movements),
            child: ListView(
              padding: const EdgeInsets.only(bottom: 20),
              children: movements.map((movement) => RoundedListTile(
                title: '${movement.text} (${movement.category.description})',
                subtitle: getFormattedDate(movement.date),
                trailing: BodyText(localization.amountCurrency(movement.amount)),
              )).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onClose,
                  child: BodyText(localization.actionsBack),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: ElevatedButton(
                  onPressed: onImport,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(theme.primaryColor),
                    side: WidgetStateProperty.all(
                      BorderSide(color: theme.primaryColorDark),
                    ),
                  ),
                  child: BodyText(
                    localization.importFromExcelImport,
                    color: getTextColor(theme.primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
