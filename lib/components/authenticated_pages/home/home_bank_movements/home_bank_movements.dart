import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements_filters.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements_simple_list.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/home_bank_movements_grouped_list.dart';
import 'package:hogastos/components/authenticated_pages/home/home_bank_movements/items_by_category.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/configurations/user_settings.dart';

class HomeBankMovements extends StatefulWidget {
  final List<Item> items;

  const HomeBankMovements({super.key, required this.items});

  @override
  State<HomeBankMovements> createState() => _HomeBankMovementsState();
}

class _HomeBankMovementsState extends State<HomeBankMovements> {
  bool _isGrouped = false;
  bool _incomesOn = true;
  bool _expensesOn = true;
  bool _notComputableOn = true;

  void _initUserSettings() async {
    var userSettings = await UserSettings().getUserSettings();

    setState(() {
      _isGrouped = userSettings.isGroupedListInHome;
    });
  }

  List<ItemsByCategory> _getFilteredList() {
    var filteredItems = widget.items.where((item) =>
      (item.isComputableIncome && _incomesOn)
        || (item.isComputableExpense && _expensesOn)
        || (item.isNotComputable && _notComputableOn)
    ).toList();

    return ItemsByCategory.getItemsByCategory(filteredItems);
  }

  void _handleToggleIncomes() => setState(() {
    _incomesOn = !_incomesOn;
  });

  void _handleToggleExpenses() => setState(() {
    _expensesOn = !_expensesOn;
  });

  void _handleToggleNotComputable() => setState(() {
    _notComputableOn = !_notComputableOn;
  });

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
    var localization = AppLocalizations.of(context)!;
    var groupedItems = _getFilteredList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SubtitleText(localization.movements),
            TextButton(
              style: ButtonStyle(
                textStyle: WidgetStatePropertyAll(TextStyle(
                  color: _isGrouped
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black87,
                ))
              ),
              onPressed: _handleToggleGrouped,
              child: BodyText(
                _isGrouped
                  ? localization.listUngroup
                  : localization.listGroupByCategory,
              ),
            ),
          ],
        ),
        HomeBankMovementsFilters(
          incomesOn: _incomesOn,
          expensesOn: _expensesOn,
          notComputableOn: _notComputableOn,
          onToggleIncomes: _handleToggleIncomes,
          onToggleExpenses: _handleToggleExpenses,
          onToggleNotComputable: _handleToggleNotComputable,
        ),
        SizedBox(height: 20),
        _isGrouped
          ? HomeBankMovementsGroupedList(items: groupedItems)
          : HomeBankMovementsSimpleList(items: groupedItems),
      ],
    );
  }
}
