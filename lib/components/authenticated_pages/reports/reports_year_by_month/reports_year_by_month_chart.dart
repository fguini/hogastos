import 'dart:math';

import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/dates/month_and_year.dart';
import 'package:hogastos/models/movement.dart';

class ReportsYearByMonthChart extends StatelessWidget {
  final List<Movement> movements;
  final bool showEmpty;

  const ReportsYearByMonthChart({
    super.key,
    required this.movements,
    required this.showEmpty,
  });

  List<double?> _getByMonth(Iterable<Movement> movements) {
    List<double?> byMonths = List.filled(12, null);

    for(var movement in movements) {
      var monthIndex = movement.date.month - 1;

      byMonths[monthIndex] = (byMonths[monthIndex] ?? 0) + movement.amount.abs();
    }

    return byMonths;
  }

  NumericGroup _getNumericGroup(String id, List<double?> amountPerMonth) {
    List<NumericData> data = [];

    for(var i = 0; i < amountPerMonth.length; i++) {
      if(showEmpty || amountPerMonth[i] != null) {
        data.add(NumericData(domain: i, measure: amountPerMonth[i] ?? 0));
      }
    }

    return NumericGroup(id: id, data: data);
  }

  NumericGroup _getIncomeNumericGroup() {
    var incomes = movements.where((m) => m.amount >= 0);
    var incomesByMonth = _getByMonth(incomes);

    return _getNumericGroup('incomes', incomesByMonth);
  }

  NumericGroup _getExpenseNumericGroup() {
    var expenses = movements.where((m) => m.amount < 0);
    var expensesByMonth = _getByMonth(expenses);

    return _getNumericGroup('expenses', expensesByMonth);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    var incomesNumericGroup = _getIncomeNumericGroup();
    var expensesNumericGroup = _getExpenseNumericGroup();

    var allMonths = [
      ...incomesNumericGroup.data.map((n) => n.domain.toInt()),
      ...expensesNumericGroup.data.map((n) => n.domain.toInt())
    ];

    var minMonth = allMonths.reduce(min);
    var maxMonth = allMonths.reduce(max);

    var desiredTicks = maxMonth - minMonth;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: DChartLineN(
        animate: true,
        domainAxis: DomainAxisN(
          viewport: NumericViewport(min: minMonth, max: maxMonth),
          numericTickProvider: NumericTickProvider(desiredTickCount: Month.values.length),
          showAxisLine: true,
          axisRenderType: AxisRenderType.gridline,
          tickLength: desiredTicks,
          tickLabelFormatter: (num? num) => num == null
            ? ''
            : localization.month(DateTime(DateTime.now().year, num.toInt() + 1)),
        ),
        measureAxis: MeasureAxis(
          numericTickProvider: NumericTickProvider(desiredTickCount: 5),
          showAxisLine: false,
        ),
        groupList: [ incomesNumericGroup, expensesNumericGroup ],
      ),
    );
  }
}
