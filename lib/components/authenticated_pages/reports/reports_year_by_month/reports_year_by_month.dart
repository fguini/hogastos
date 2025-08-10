import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/movement.dart';

import 'reports_year_by_month_chart.dart';

class ReportsYearByMonth extends StatelessWidget {
  final bool isLoading;
  final List<Movement> movements;

  const ReportsYearByMonth({
    super.key,
    this.isLoading = false,
    required this.movements,
  });

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitleText(localization.reportsYearByMonthTitle),
        ReportsYearByMonthChart(
          isLoading: isLoading,
          movements: movements,
        ),
      ],
    );
  }
}
