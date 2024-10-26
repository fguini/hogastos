import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/home_date_navigator.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/authenticated_pages/home/home_totals/home_totals.dart';

const cardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  MonthAndYear _currentMonthAndYear = MonthAndYear(
    month: Month.values.firstWhere((month) => month.index == DateTime.now().month - 1),
    year: DateTime.now().year
  );

  void _handleChangeMonthAndYear(MonthAndYear monthAndYear) => setState(() {
    _currentMonthAndYear = monthAndYear;
  });

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
            child: HomeTotals(),
          ),
        ),
        Flexible(
          child: Card(
            child: Container(
              padding: cardPadding,
              child: HomeBankMovements(),
            ),
          ),
        ),
      ],
    );
  }
}
