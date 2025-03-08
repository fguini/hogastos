import 'package:flutter/material.dart';
import 'package:hogastos/components/common/box_selector.dart';
import 'package:hogastos/configurations/hogastos_icons/hostastos_icon.dart';
import 'package:hogastos/helpers/localization_helper.dart';

class IconSelector extends StatelessWidget {
  final HogastosIcon? selectedIcon;
  final bool enabled;
  final void Function(HogastosIcon?) onChanged;

  const IconSelector({
    super.key,
    this.selectedIcon,
    this.enabled = true,
    required this.onChanged
  });

  Widget _getBoxContentWidget(HogastosIcon icon) => Icon(
    icon.iconData
  );

  bool isEqual(item1, item2) => item1.key == item2?.key;

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return BoxSelector<HogastosIcon>(
      selectedValue: selectedIcon,
      enabled: enabled,
      items: HogastosIcons.values,
      label: localization.categorySelectIcon,
      getBoxContentWidget: _getBoxContentWidget,
      isEqual: isEqual,
      onChanged: onChanged,
    );
  }
}
