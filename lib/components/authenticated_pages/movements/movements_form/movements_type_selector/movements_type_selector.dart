import 'package:flutter/material.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/movement_type.dart';

class MovementsTypeSelector extends StatelessWidget {
  final MovementType? selectedType;
  final bool isLoading;
  final void Function(MovementType type) onTypeChange;

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
      child: SegmentedButton<MovementType>(
        segments: [
          ButtonSegment(
            value: MovementType.computable,
            label: Text(localization.computable),
            enabled: !isLoading,
          ),
          ButtonSegment(
            value: MovementType.notComputable,
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
