import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/movement.dart';

import 'reports_year_by_category_chart.dart';

class ReportsYearByCategory extends StatelessWidget {
  final List<Movement> movements;

  const ReportsYearByCategory({
    super.key,
    required this.movements,
  });

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SubtitleText(localization.reportsYearByCategoryTitle),
          ],
        ),
        ReportsYearByCategoryChart(
          movements: movements,
        ),
      ],
    );
  }
}
