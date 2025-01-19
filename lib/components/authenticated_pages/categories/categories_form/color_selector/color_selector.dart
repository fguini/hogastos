import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/input_text.dart';
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
  final void Function(Color) onChanged;

  const ColorSelector({
    super.key,
    this.selectedColor,
    this.enabled = true,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);
    double boxSize = 40;

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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 6),
              InputText(localization.categorySelectColor, enabled: enabled),
            ],
          ),
          SizedBox(height: 10),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.spaceEvenly,
                runSpacing: 10,
                spacing: 10,
                children: _colors.map((color) => InkWell(
                  onTap: enabled ? () => onChanged(color) : null,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Container(
                    height: boxSize,
                    width: boxSize,
                    decoration: BoxDecoration(
                      color: enabled ? color : color.withAlpha(80),
                      border: Border.all(
                        color: enabled ? Colors.black54 : Colors.black54.withAlpha(80),
                        width: color == selectedColor ? 4 : 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                )).toList(),
              )
            ],
          )
        ],
      ),
    );
  }
}
