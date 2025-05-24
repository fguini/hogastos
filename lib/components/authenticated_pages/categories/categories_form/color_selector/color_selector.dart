import 'package:flutter/material.dart';
import 'package:hogastos/components/common/box_selector.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';

List<Color> _colors = [
  Colors.white60,
  Colors.grey,
  Colors.black54,
  Colors.tealAccent,
  Colors.greenAccent,
  Colors.lightGreenAccent,
  Colors.green,
  Colors.cyanAccent,
  Colors.lightBlueAccent,
  Colors.blueAccent,
  Colors.deepPurple,
  Colors.purple,
  Colors.purpleAccent,
  Colors.pink,
  Colors.redAccent,
  Colors.deepOrange,
  Colors.amber,
  Colors.yellowAccent,
];

class ColorSelector extends StatelessWidget {
  final Color? selectedColor;
  final bool enabled;
  final Map<String, int> usedColors;
  final void Function(Color) onChanged;

  const ColorSelector({
    super.key,
    this.selectedColor,
    this.enabled = true,
    this.usedColors = const {},
    required this.onChanged
  });

  Color _getColor(Color color) => enabled ? color : color.withAlpha(80);
  bool isEqual(color1, color2) =>
      getColorStringSignature(color1) == getColorStringSignature(color2 ?? Colors.white);

  String getColorId(Color color) => getColorStringSignature(color);

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return BoxSelector<Color>(
      selectedValue: selectedColor,
      enabled: enabled,
      items: _colors,
      label: localization.categorySelectColor,
      getItemId: getColorId,
      usedItems: usedColors,
      getColor: _getColor,
      isEqual: isEqual,
      onChanged: onChanged,
    );
  }
}
