import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';

const _expenseId = 'expense';
const _incomeId = 'income';

class MovementTotalsChart extends StatelessWidget {
  final double expenses;
  final double incomes;

  const MovementTotalsChart({
    super.key,
    required this.expenses,
    required this.incomes
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var localization = LocalizationHelper.localization(context);
    var themeTextColor = getDefaultThemeTextColor(theme);

    return AspectRatio(
      aspectRatio: 4,
      child: DChartBarO(
        animate: true,
        arrangeVertically: true,
        layoutMargin: LayoutMargin(75, 10, 0, 5),
        domainAxis: DomainAxisO(
          showAxisLine: false,
          labelStyle: LabelStyle(
            color: themeTextColor,
            fontSize: 16,
          ),
          tickLabelJustification: TickLabelJustification.outside,
        ),
        measureAxis: MeasureAxis(noRenderSpec: true, showAxisLine: false),
        renderType: (_) => RenderType.barLane,
        configSeriesBarLane: ConfigSeriesBarLaneO(
          customColor: (_, data, _) => data.domain == _expenseId
            ? theme.colorScheme.error
            : theme.colorScheme.primary,
          domain: (_, data, _) => data.domain == _expenseId
            ? localization.expenses
            : localization.incomes,
          labelAccessor: (_, data, _) => localization.amountCurrency(
            data.measure?.toDouble() ?? 0
          ),
          showBarLabel: true,
          cornerRadius: 50,
          backgroundBarColor: theme.colorScheme.primary.withValues(alpha: 0.1),
          barLabelDecorator: BarLabelDecoratorO(
            labelAnchor: BarLabelAnchor.end,
            labelPadding: 15,
            outsideLabelStyle: LabelStyle(color: themeTextColor),
          ),
        ),
        groupList: [
          OrdinalGroup(id: 'totals', data: [
            OrdinalData(domain: _incomeId, measure: incomes),
            OrdinalData(domain: _expenseId, measure: expenses),
          ]),
        ],
      ),
    );
  }
}
