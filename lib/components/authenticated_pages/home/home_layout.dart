import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/home_date_navigator.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/authenticated_pages/home/home_totals/home_totals.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/services/movement_service.dart';

const cardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  StreamSubscription<List<Movement>>? watcher;
  List<Movement> _movements = [];
  MonthAndYear _currentMonthAndYear = MonthAndYear.now();
  bool _isLoading = false;

  void _loadMonthAndYearMovements(MonthAndYear newMonthAndYear) {
    setState(() {
      _movements = [];
      _currentMonthAndYear = newMonthAndYear;
      _isLoading = true;
    });

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

  void _handleChangeMonthAndYear(MonthAndYear monthAndYear)
    => _loadMonthAndYearMovements(monthAndYear);

  @override
  void dispose() {
    watcher?.cancel();
    watcher = null;

    super.dispose();
  }

  @override
  void initState() {
    _loadMonthAndYearMovements(MonthAndYear.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: HomeDateNavigator(
            monthAndYear: _currentMonthAndYear,
            onChange: _handleChangeMonthAndYear,
          ),
        ),
        Card(
          child: Container(
            padding: cardPadding,
            child: HomeTotals(
              items: _movements,
              isLoading: _isLoading,
            ),
          ),
        ),
        Flexible(
          child: Card(
            child: Container(
              padding: cardPadding,
              child: HomeBankMovements(
                items: _movements,
                isLoading: _isLoading,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
