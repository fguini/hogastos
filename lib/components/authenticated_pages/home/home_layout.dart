import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/home_date_navigator.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/authenticated_pages/home/home_totals/home_totals.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/models/movement_type.dart';

var _category1 = Category(1, 'churrin1', Colors.greenAccent, Icons.church);
var _category2 = Category(2, 'churrin2', Colors.purple, Icons.incomplete_circle);
var _category3 = Category(3, 'churrin3', Colors.blueAccent, Icons.local_airport);

var _items = [
  Movement(1, 'test1', _category1, 20, DateTime.now(), MovementType.computable),
  Movement(2, 'test2', _category2, 10, DateTime.now(), MovementType.computable),
  Movement(3, 'test3', _category3, 4, DateTime.now(), MovementType.computable),
  Movement(4, 'test4', _category1, -49, DateTime.now(), MovementType.computable),
  Movement(5, 'test5', _category1, 16, DateTime.now(), MovementType.computable),
  Movement(6, 'test6', _category2, -20.32, DateTime.now(), MovementType.computable),
  Movement(7, 'test7', _category2, -120, DateTime.now(), MovementType.computable),
  Movement(8, 'test8', _category2, 1, DateTime.now(), MovementType.computable),
  Movement(9, 'test9', _category3, -12, DateTime.now(), MovementType.computable),
  Movement(10, 'test10', _category1, -32, DateTime.now(), MovementType.computable),
  Movement(11, 'test11', _category1, 44, DateTime.now(), MovementType.computable),
];

const cardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Movement> _movements = [];
  MonthAndYear _currentMonthAndYear = MonthAndYear.now();
  bool _isLoading = false;

  void _loadMonthAndYearMovements(MonthAndYear newMonthAndYear) {
    setState(() {
      _movements = [];
      _currentMonthAndYear = newMonthAndYear;
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        _movements = _items;
        _isLoading = false;
      });
    });
  }

  void _handleChangeMonthAndYear(MonthAndYear monthAndYear)
    => _loadMonthAndYearMovements(monthAndYear);

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
