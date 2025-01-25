import 'package:flutter/material.dart';
import 'package:hogastos/helpers/localization_helper.dart';

import 'income_expense.dart';

class MovementsIncomeExpenseSelector extends StatelessWidget {
  final IncomeExpense? selectedType;
  final bool isLoading;
  final void Function(IncomeExpense type) onTypeChange;

  const MovementsIncomeExpenseSelector({
    super.key,
    required this.selectedType,
    this.isLoading = false,
    required this.onTypeChange
  });

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<IncomeExpenseType>(
        segments: [
          ButtonSegment(
            value: IncomeExpenseType.income,
            label: Text(localization.income),
            enabled: !isLoading,
          ),
          ButtonSegment(
            value: IncomeExpenseType.expense,
            label: Text(localization.expense),
            enabled: !isLoading,
          ),
        ],
        selected: selectedType != null
          ? {selectedType!.type}
          : {},
        onSelectionChanged: (newSet) {
          var newType = newSet.first;

          onTypeChange(IncomeExpense(newType));
        },
      ),
    );
  }
}
