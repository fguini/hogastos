import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements_grouped_list.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements_simple_list.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/configurations/user_settings.dart';

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

class Item {
  final String text;
  final Category category;
  final double amount;

  Item(this.text, this.category, this.amount);
}

var items = [
  Item('test1', Category(1, 'churrin1', Colors.greenAccent), 20),
  Item('test2', Category(2, 'churrin2', Colors.purple), 10),
  Item('test3', Category(3, 'churrin3', Colors.blueAccent), 4),
  Item('test4', Category(1, 'churrin1', Colors.greenAccent), -49),
  Item('test5', Category(1, 'churrin1', Colors.greenAccent), 16),
  Item('test6', Category(2, 'churrin2', Colors.purple), -20.32),
  Item('test7', Category(2, 'churrin2', Colors.purple), -120),
  Item('test8', Category(2, 'churrin2', Colors.purple), 1),
  Item('test9', Category(3, 'churrin3', Colors.blueAccent), -12),
  Item('test10', Category(1, 'churrin1', Colors.greenAccent), -32),
  Item('test11', Category(1, 'churrin1', Colors.greenAccent), 44),
];

class HomeBankMovements extends StatefulWidget {
  const HomeBankMovements({super.key});

  @override
  State<HomeBankMovements> createState() => _HomeBankMovementsState();
}

class _HomeBankMovementsState extends State<HomeBankMovements> {
  bool _isGrouped = false;

  void _initUserSettings() async {
    var userSettings = await UserSettings().getUserSettings();

    setState(() {
      _isGrouped = userSettings.isGroupedListInHome;
    });
  }

  @override
  void initState() {
    _initUserSettings();

    super.initState();
  }

  void _handleToggleGrouped() {
    var newIsGrouped = !_isGrouped;

    UserSettings().saveIsGroupedListInHome(newIsGrouped);

    setState(() {
      _isGrouped = newIsGrouped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubtitleText('Movimientos'), // TODO translate
            TextButton(
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(TextStyle(
                  color: _isGrouped
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black87
                ))
              ),
              onPressed: _handleToggleGrouped,
              child: BodyText(
                _isGrouped
                  ? 'Desagrupar lista'
                  : 'Agrupar por categoría'
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primaryContainer
                  )
                ),
                child: BodyText('Ingresos'), // TODO translate
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.errorContainer
                  )
                ),
                child: BodyText('Gastos'), // TODO translate
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        _isGrouped
          ? HomeBankMovementsGroupedList(items: items)
          : HomeBankMovementsSimpleList(items: items),
      ],
    );
  }
}
