import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/authenticated_pages/reports/reports_year_by_month/reports_year_by_month.dart';
import 'package:hogastos/components/common/date_navigator.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/components/common/layout_card.dart';
import 'package:hogastos/components/common/movement_totals/movement_totals.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/dates/navigable_date.dart';
import 'package:hogastos/models/dates/navigable_year.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/services/movement_service.dart';

class ReportsYear extends StatefulWidget {
  const ReportsYear({super.key});

  @override
  State<ReportsYear> createState() => _ReportsYearState();
}

class _ReportsYearState extends State<ReportsYear> {
  bool _isLoading = true;
  List<Movement> _movements = [];
  NavigableYear _year = NavigableYear.now();

  void _handleChange(NavigableDate newDate) {
    var newYear = newDate as NavigableYear;

    setState(() => _year = newYear);
    _getMovements(newYear.value);
  }

  void _getMovements(int year) {
    MovementService().getByYear(year)
      .then((movements) => setState(() {
        _movements = movements;
      }))
      .whenComplete(() => setState(() {
        _isLoading = false;
      }));
  }

  @override
  void initState() {
    _getMovements(_year.value);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: LocalizationHelper.localization(context).reportsYearTitle,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: DateNavigator<NavigableYear>(
                value: _year,
                onChange: _handleChange,
              ),
            ),
            LayoutCard(
              child: MovementTotals(
                isLoading: _isLoading,
                items: _movements,
              ),
            ),
            LayoutCard(
              child: ReportsYearByMonth(
                isLoading: _isLoading,
                movements: _movements,
              ),
            ),
          ],
        ),
      ),
      leading: GoHomeAction(popUntilHome: true),
    );
  }
}
