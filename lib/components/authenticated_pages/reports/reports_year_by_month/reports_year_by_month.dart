import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/movement.dart';

import 'reports_year_by_month_chart.dart';

class ReportsYearByMonth extends StatefulWidget {
  final bool isLoading;
  final List<Movement> movements;

  const ReportsYearByMonth({
    super.key,
    this.isLoading = false,
    required this.movements,
  });

  @override
  State<ReportsYearByMonth> createState() => _ReportsYearByMonthState();
}

class _ReportsYearByMonthState extends State<ReportsYearByMonth> {
  bool _showEmpty = true;

  void _handleToggleShowEmpty() => setState(() => _showEmpty = !_showEmpty);

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubtitleText(localization.reportsYearByMonthTitle),
            TextButton(
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(
                  TextStyle(
                    color: _showEmpty
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black87,
                  ),
                ),
              ),
              onPressed: _handleToggleShowEmpty,
              child: BodyText(
                _showEmpty
                  ? localization.reportsYearByMonthNotShowEmpty
                  : localization.reportsYearByMonthShowEmpty,
              ),
            ),
          ],
        ),
        ReportsYearByMonthChart(
          isLoading: widget.isLoading,
          movements: widget.movements,
          showEmpty: _showEmpty,
        ),
      ],
    );
  }
}
