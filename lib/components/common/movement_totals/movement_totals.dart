import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/components/texts/title_text.dart';
import 'package:hogastos/models/movement.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'movement_totals_chart.dart';

class MovementTotals extends StatelessWidget {
  final List<Movement> items;
  final bool isLoading;

  const MovementTotals({
    super.key,
    required this.items,
    required this.isLoading
  });

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context)!;

    var incomes = items
      .where((item) => item.isComputableIncome)
      .map((item) => item.amount)
      .fold<double>(0, (amount1, amount2) => amount1 + amount2);
    var expenses = items
      .where((item) => item.isComputableExpense)
      .map((item) => item.amount * -1)
      .fold<double>(0, (amount1, amount2) => amount1 + amount2);

    var totals = incomes - expenses;
    var maxAmount = max(incomes, expenses) + 40;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleText(localization.totals),
            Skeletonizer.zone(
              child: isLoading
                ? LoadingSubtitleText(width: 100)
                : SubtitleText(localization.amountCurrency(totals)),
            ),
          ],
        ),
        MovementTotalsChart(
          expenses: expenses,
          incomes: incomes,
        ),
      ],
    );
  }
}
