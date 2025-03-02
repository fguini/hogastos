import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/color_helper.dart';

class _FilterButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final bool isTurnedOn;
  final VoidCallback onPressed;

  const _FilterButton({
    required this.text,
    required this.backgroundColor,
    required this.isTurnedOn,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var offBackgroundColor = Colors.white70;
    var finalBackgroundColor = isTurnedOn
      ? backgroundColor.withAlpha(80)
      : offBackgroundColor;

    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(finalBackgroundColor),
          elevation: WidgetStateProperty.all(isTurnedOn ? 1 : 0),
          side: WidgetStateProperty.all(
            BorderSide(
              color: backgroundColor
            )
          ),
        ),
        child: BodyText(
          text,
          color: getTextColor(finalBackgroundColor),
        ),
      ),
    );
  }
}


class HomeBankMovementsFilters extends StatelessWidget {
  final bool incomesOn;
  final bool expensesOn;
  final bool notComputableOn;
  final VoidCallback onToggleIncomes;
  final VoidCallback onToggleExpenses;
  final VoidCallback onToggleNotComputable;

  const HomeBankMovementsFilters({
    super.key,
    required this.incomesOn,
    required this.expensesOn,
    required this.notComputableOn,
    required this.onToggleIncomes,
    required this.onToggleExpenses,
    required this.onToggleNotComputable,
  });

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;
    var theme = Theme.of(context);

    var separator = SizedBox(width: 10);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _FilterButton(
          text: localization.incomes,
          backgroundColor: theme.colorScheme.primary,
          isTurnedOn: incomesOn,
          onPressed: onToggleIncomes,
        ),
        separator,
        _FilterButton(
          text: localization.expenses,
          backgroundColor: theme.colorScheme.error,
          isTurnedOn: expensesOn,
          onPressed: onToggleExpenses,
        ),
        separator,
        _FilterButton(
          text: localization.notComputableShort,
          backgroundColor: theme.colorScheme.secondary,
          isTurnedOn: notComputableOn,
          onPressed: onToggleNotComputable,
        ),
      ],
    );
  }
}
