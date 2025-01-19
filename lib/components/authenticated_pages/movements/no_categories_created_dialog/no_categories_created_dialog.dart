import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/title_text.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';

class NoCategoriesCreatedDialog extends StatelessWidget {
  final void Function(int?) onPop;

  const NoCategoriesCreatedDialog({super.key, required this.onPop});

  void _handleGoBack(BuildContext context) => NavigatorHelper.pushNamedAndRemoveUntil(
    context,
    RoutesNames.home,
  );

  void _handleGoToCreation(BuildContext context) async {
    var categoryId = await NavigatorHelper.pushNamed(
      context,
      RoutesNames.categoriesCreate,
      arguments: RoutesNames.movementsCreate,
    ) as int?;

    onPop(categoryId);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);
    var theme = Theme.of(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TitleText(localization.noCategoriesDialogTitle),
            SizedBox(height: 8),
            BodyText(localization.noCategoriesDialogDescription),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _handleGoBack(context),
                    child: BodyText(localization.actionsBack),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _handleGoToCreation(context),
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(theme.primaryColor),
                      side: WidgetStateProperty.all(
                        BorderSide(color: theme.primaryColorDark),
                      ),
                    ),
                    child: BodyText(
                      localization.actionsGo,
                      color: getTextColor(theme.primaryColor),
                    )
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
