import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements_simple_list.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements_grouped_list.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/items_by_category.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/configurations/user_settings.dart';

class HomeBankMovements extends StatefulWidget {
  late final List<ItemsByCategory> _items;

  HomeBankMovements({super.key, required List<Item> items}) {
    _items = ItemsByCategory.getItemsByCategory(items);
  }

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
          ? HomeBankMovementsGroupedList(items: widget._items)
          : HomeBankMovementsSimpleList(items: widget._items),
      ],
    );
  }
}
