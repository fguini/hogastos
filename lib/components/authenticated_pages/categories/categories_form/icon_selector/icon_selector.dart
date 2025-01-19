import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_iconpicker/Models/configuration.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/hint_text.dart';
import 'package:hogastos/components/texts/input_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';

class IconSelector extends StatelessWidget {
  final IconData? selectedIcon;
  final bool enabled;
  final void Function(IconData?) onChanged;

  const IconSelector({
    super.key,
    this.selectedIcon,
    this.enabled = true,
    required this.onChanged
  });

  void _handleOpenPicker(BuildContext context, Localization localization) async {
    IconPickerIcon? icon = await showIconPicker(
      context,
      configuration: SinglePickerConfiguration(
        iconPackModes: [IconPack.material],
        preSelected: selectedIcon != null
          ? IconPickerIcon(
            data: selectedIcon!,
            name: localization.categorySelectIcon,
            pack: IconPack.material
          )
          : null,
        title: SubtitleText(localization.categorySelectIcon),
        closeChild: BodyText(localization.actionsClose),
        searchHintText: localization.actionsSearch,
        noResultsText: localization.categorySelectIconNoResults,
      ),
    );

    onChanged(icon?.data);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: enabled ? Colors.black54 : Colors.black12),
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 6),
              InputText(localization.categorySelectIcon, enabled: enabled),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: enabled ? Colors.black54 : Colors.black12,
                    width: 1
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: IconButton(
                  icon: Icon(
                    selectedIcon ?? Icons.crop_square_sharp,
                    color: enabled ? Colors.black54 : Colors.black12,
                  ),
                  onPressed: enabled
                    ? () => _handleOpenPicker(context, localization)
                    : null,
                ),
              ),
              SizedBox(width: 14),
              ...selectedIcon == null
                ? [HintText(localization.categorySelectIconNotSelected)]
                : [],
            ],
          ),
        ],
      ),
    );
  }
}
