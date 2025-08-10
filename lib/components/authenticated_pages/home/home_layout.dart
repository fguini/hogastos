import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements.dart';
import 'package:hogastos/components/common/date_navigator.dart';
import 'package:hogastos/components/common/layout_card.dart';
import 'package:hogastos/components/common/movement_totals/movement_totals.dart';
import 'package:hogastos/models/dates/month_and_year.dart';
import 'package:hogastos/configurations/user_settings.dart';
import 'package:hogastos/models/dates/navigable_date.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/services/movement_service.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  StreamSubscription<List<Movement>>? watcher;
  List<Movement> _movements = [];
  MonthAndYear _currentMonthAndYear = MonthAndYear.now();
  bool _isLoading = true;

  void _loadMonthAndYearMovements(MonthAndYear newMonthAndYear) {
    setState(() {
      _movements = [];
      _currentMonthAndYear = newMonthAndYear;
      _isLoading = true;
    });

    UserSettings().saveMonthAndYearInHome(newMonthAndYear);

    watcher = MovementService().watchByMonthAndYear(
      newMonthAndYear.monthNumber,
      newMonthAndYear.year
    ).listen((watchedMovements) {
      if(context.mounted) {
        setState(() {
          _movements = watchedMovements;
          _isLoading = false;
        });
      }
    });
  }

  void _handleChangeMonthAndYear(NavigableDate monthAndYear)
    => _loadMonthAndYearMovements(monthAndYear as MonthAndYear);

  @override
  void dispose() {
    watcher?.cancel();
    watcher = null;

    super.dispose();
  }

  @override
  void initState() {
    UserSettings().getUserSettings().then((settings) {
      _loadMonthAndYearMovements(settings.monthAndYearInHome);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: DateNavigator<MonthAndYear>(
            value: _currentMonthAndYear,
            onChange: _handleChangeMonthAndYear,
          ),
        ),
        LayoutCard(
          child: MovementTotals(
            items: _movements,
            isLoading: _isLoading,
          ),
        ),
        Flexible(
          child: LayoutCard(
            child: HomeBankMovements(
              items: _movements,
              isLoading: _isLoading,
            ),
          ),
        ),
      ],
    );
  }
}
