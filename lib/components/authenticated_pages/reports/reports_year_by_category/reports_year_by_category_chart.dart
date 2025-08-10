import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/movement.dart';

class ReportsYearByCategoryChart extends StatelessWidget {
  final List<Movement> movements;

  const ReportsYearByCategoryChart({
    super.key,
    required this.movements,
  });

  Map<int, double> _getCategoriesBalance() {
    var computable = movements.where((m) => m.isComputable);
    Map<int, double> categoriesBalance = {};

    for(var movement in computable) {
      var category = movement.category.id;
      var categoryBalance = categoriesBalance[category] ?? 0;

      categoriesBalance[category] = categoryBalance + movement.amount;
    }

    return categoriesBalance;
  }

  String _getCategoryDescription(int categoryId) => movements.where(
    (m) => m.category.id == categoryId
  ).firstOrNull?.category.description ?? '';

  Color? _getCategoryColor(int categoryId) => movements.where(
    (m) => m.category.id == categoryId
  ).firstOrNull?.category.color;

  List<OrdinalData> _getOrdinalData() {
    List<OrdinalData> data = [];
    var balance = _getCategoriesBalance();

    for(var categoryId in balance.keys) {
      var measure = balance[categoryId]!;

      if(measure <= 0) {
        data.add(
          OrdinalData(
            domain: categoryId.toString(),
            measure: measure.abs(),
          ),
        );
      }
    }

    data.sort((d1, d2) {
      var d1Measure = d1.measure?.toDouble() ?? 0;
      var d2Measure = d2.measure?.toDouble() ?? 0;

      return (d2Measure - d1Measure).toInt();
    });

    return data;
  }

  OrdinalGroup _getOrdinalGroup() => OrdinalGroup(
    id: 'per-category',
    data: _getOrdinalData(),
  );

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return AspectRatio(
      aspectRatio: 0.7,
      child: DChartBarO(
        animate: true,
        arrangeVertically: true,
        domainAxis: DomainAxisO(noRenderSpec: true),
        measureAxis: MeasureAxis(noRenderSpec: true, showAxisLine: false),
        configSeriesBar: ConfigSeriesBarO(
          customColor: (_, data, _) => _getCategoryColor(int.parse(data.domain)) ?? Colors.amber,
          domain: (_, data, _) => '${_getCategoryDescription(int.parse(data.domain))} ${localization.amountCurrency(data.measure?.toDouble() ?? 0)}',
          cornerRadius: 50,
          showBarLabel: true,
          barLabelDecorator: BarLabelDecoratorO(
            labelPadding: 12,
          ),
        ),
        groupList: [ _getOrdinalGroup() ],
      ),
    );
  }
}
