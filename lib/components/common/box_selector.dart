import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/input_text.dart';

class BoxSelector<T> extends StatelessWidget {
  final T? selectedValue;
  final bool enabled;
  final List<T> items;
  final String label;
  final Map<String, int> usedItems;
  final String Function(T)? getItemId;
  final Color Function(T)? getColor;
  final Widget Function(T)? getBoxContentWidget;
  final bool Function(T, T?)? isEqual;
  final void Function(T) onChanged;

  const BoxSelector({
    super.key,
    this.selectedValue,
    required this.enabled,
    required this.items,
    required this.label,
    this.usedItems = const {},
    this.getItemId,
    this.getColor,
    this.getBoxContentWidget,
    this.isEqual,
    required this.onChanged,
  });

  bool isSelected(T item, T? selectedItem) => isEqual != null
    ? isEqual!(item, selectedItem)
    : item == selectedItem;

  @override
  Widget build(BuildContext context) {
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
              InputText(label, enabled: enabled),
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
                children: items.map((item) {
                  var itemId = getItemId != null ? getItemId!(item) : item.toString();
                  var used = usedItems.containsKey(itemId)
                    ? usedItems[itemId]
                    : null;

                  return InkWell(
                    onTap: enabled ? () => onChanged(item) : null,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Badge(
                      label: Text(used?.toString() ?? ''),
                      isLabelVisible: used != null,
                      child: Container(
                        height: boxSize,
                        width: boxSize,
                        decoration: BoxDecoration(
                          color: getColor != null
                            ? getColor!(item)
                            : null,
                          border: Border.all(
                            color: enabled ? Colors.black54 : Colors.black54.withAlpha(80),
                            width: isSelected(item, selectedValue) ? 4 : 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: getBoxContentWidget != null
                          ? getBoxContentWidget!(item)
                          : null,
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          )
        ],
      ),
    );
  }
}
