import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/home_date_navigator.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/authenticated_pages/home/home_totals/home_totals.dart';

class Category {
  final int id;
  final String description;
  final Color color;
  final IconData icon;

  Category(
    this.id,
    this.description,
    this.color,
    this.icon,
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

var _category1 = Category(1, 'churrin1', Colors.greenAccent, Icons.church);
var _category2 = Category(2, 'churrin2', Colors.purple, Icons.incomplete_circle);
var _category3 = Category(3, 'churrin3', Colors.blueAccent, Icons.local_airport);

var _items = [
  Item('test1', _category1, 20, DateTime.now(), ItemType.computable),
  Item('test2', _category2, 10, DateTime.now(), ItemType.computable),
  Item('test3', _category3, 4, DateTime.now(), ItemType.computable),
  Item('test4', _category1, -49, DateTime.now(), ItemType.computable),
  Item('test5', _category1, 16, DateTime.now(), ItemType.computable),
  Item('test6', _category2, -20.32, DateTime.now(), ItemType.computable),
  Item('test7', _category2, -120, DateTime.now(), ItemType.computable),
  Item('test8', _category2, 1, DateTime.now(), ItemType.computable),
  Item('test9', _category3, -12, DateTime.now(), ItemType.computable),
  Item('test10', _category1, -32, DateTime.now(), ItemType.computable),
  Item('test11', _category1, 44, DateTime.now(), ItemType.computable),
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
