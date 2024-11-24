import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/home_date_navigator.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/authenticated_pages/home/home_totals/home_totals.dart';

class Category {
  final int id;
  final String description;
  final Color color;

  Category(
    this.id,
    this.description,
    this.color
  );
}

enum ItemType {
  computable,
  notComputable,
}

class Item {
  final String text;
  final Category category;
  final double amount;
  final DateTime date;
  final ItemType type;

  Item(
    this.text,
    this.category,
    this.amount,
    this.date,
    this.type,
  );

  bool get isComputable => type == ItemType.computable;
  bool get isNotComputable => type == ItemType.notComputable || amount == 0;

  bool get isIncome => amount > 0;
  bool get isExpense => amount < 0;

  bool get isComputableIncome => isComputable && isIncome;
  bool get isComputableExpense => isComputable && isExpense;
}

var _items = [
  Item('test1', Category(1, 'churrin1', Colors.greenAccent), 20, DateTime.now(), ItemType.computable),
  Item('test2', Category(2, 'churrin2', Colors.purple), 10, DateTime.now(), ItemType.computable),
  Item('test3', Category(3, 'churrin3', Colors.blueAccent), 4, DateTime.now(), ItemType.computable),
  Item('test4', Category(1, 'churrin1', Colors.greenAccent), -49, DateTime.now(), ItemType.computable),
  Item('test5', Category(1, 'churrin1', Colors.greenAccent), 16, DateTime.now(), ItemType.computable),
  Item('test6', Category(2, 'churrin2', Colors.purple), -20.32, DateTime.now(), ItemType.computable),
  Item('test7', Category(2, 'churrin2', Colors.purple), -120, DateTime.now(), ItemType.computable),
  Item('test8', Category(2, 'churrin2', Colors.purple), 1, DateTime.now(), ItemType.computable),
  Item('test9', Category(3, 'churrin3', Colors.blueAccent), -12, DateTime.now(), ItemType.computable),
  Item('test10', Category(1, 'churrin1', Colors.greenAccent), -32, DateTime.now(), ItemType.computable),
  Item('test11', Category(1, 'churrin1', Colors.greenAccent), 44, DateTime.now(), ItemType.computable),
];

const cardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  MonthAndYear _currentMonthAndYear = MonthAndYear.now();

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
            child: HomeTotals(items: _items),
          ),
        ),
        Flexible(
          child: Card(
            child: Container(
              padding: cardPadding,
              child: HomeBankMovements(items: _items),
            ),
          ),
        ),
      ],
    );
  }
}
