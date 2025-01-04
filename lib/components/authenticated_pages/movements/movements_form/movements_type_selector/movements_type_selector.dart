import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/helpers/localization_helper.dart';

class MovementsTypeSelector extends StatelessWidget {
  final ItemType? selectedType;
  final bool isLoading;
  final void Function(ItemType type) onTypeChange;

  const MovementsTypeSelector({
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
      child: SegmentedButton<ItemType>(
        segments: [
          ButtonSegment(
            value: ItemType.computable,
            label: Text(localization.computable),
            enabled: !isLoading,
          ),
          ButtonSegment(
            value: ItemType.notComputable,
            label: Text(localization.notComputable),
            enabled: !isLoading,
          ),
        ],
        selected: selectedType != null
            ? { selectedType! }
            : {},
        onSelectionChanged: (newSet) {
          var newType = newSet.first;

          onTypeChange(newType);
        },
      ),
    );
  }
}
