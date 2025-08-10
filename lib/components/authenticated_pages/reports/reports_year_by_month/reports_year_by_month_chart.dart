import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/movement.dart';

class ReportsYearByMonthChart extends StatelessWidget {
  final bool isLoading;
  final List<Movement> movements;

  const ReportsYearByMonthChart({
    super.key,
    this.isLoading = false,
    required this.movements,
  });

  List<double> _getByMonth(Iterable<Movement> movements) {
    List<double> byMonths = List.filled(12, 0);

    for(var movement in movements) {
      var monthIndex = movement.date.month - 1;

      byMonths[monthIndex] += movement.amount.abs();
    }

    return byMonths;
  }

  NumericGroup _getNumericGroup(String id, List<double> amountPerMonth) {
    List<NumericData> data = [];

    for(var i = 0; i < amountPerMonth.length; i++) {
      data.add(NumericData(domain: i, measure: amountPerMonth[i]));
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

    return AspectRatio(
      aspectRatio: 2,
      child: DChartLineN(
        animate: true,
        domainAxis: DomainAxisN(
          numericTickProvider: NumericTickProvider(desiredTickCount: 12),
          showAxisLine: true,
          axisRenderType: AxisRenderType.gridline,
          tickLength: 12,
          tickLabelFormatter: (num? num) => num == null
            ? ''
            : localization.month(DateTime(DateTime.now().year, num.toInt() + 1)),
        ),
        measureAxis: MeasureAxis(
          numericTickProvider: NumericTickProvider(desiredTickCount: 6),
          showAxisLine: false,
        ),
        groupList: [
          _getIncomeNumericGroup(),
          _getExpenseNumericGroup(),
        ],
      ),
    );
  }
}
