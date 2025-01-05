import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';

const double borderRadius = 10;

typedef _AutocompleteOptionToWidget<T extends Object> = Widget Function(T);

class _AutocompleteOptions<T extends Object> extends StatelessWidget {
  const _AutocompleteOptions({
    super.key,
    required this.displayWidgetForOption,
    required this.onSelected,
    required this.openDirection,
    required this.options,
    required this.maxOptionsHeight,
  });

  final _AutocompleteOptionToWidget<T> displayWidgetForOption;

  final AutocompleteOnSelected<T> onSelected;
  final OptionsViewOpenDirection openDirection;

  final Iterable<T> options;
  final double maxOptionsHeight;

  @override
  Widget build(BuildContext context) {
    final AlignmentDirectional optionsAlignment = switch (openDirection) {
      OptionsViewOpenDirection.up => AlignmentDirectional.bottomStart,
      OptionsViewOpenDirection.down => AlignmentDirectional.topStart,
    };

    return Align(
      alignment: optionsAlignment,
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(borderRadius),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxOptionsHeight,
            maxWidth: MediaQuery.of(context).size.width * 0.9,
          ),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              final T option = options.elementAt(index);
              return InkWell(
                onTap: () {
                  onSelected(option);
                },
                child: Builder(
                  builder: (BuildContext context) {
                    final bool highlight = AutocompleteHighlightedOption.of(context) == index;
                    if (highlight) {
                      SchedulerBinding.instance.addPostFrameCallback(
                        (Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        },
                        debugLabel: 'AutocompleteOptions.ensureVisible',
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: highlight
                          ? Theme.of(context).primaryColorLight
                          : null,
                      ),
                      child: displayWidgetForOption(option),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

typedef OptionsViewBuilder = Widget Function(
  BuildContext context,
  AutocompleteOnSelected<Category> onSelected,
  Iterable<Category> options,
);

OptionsViewBuilder optionsViewBuilder(
  {
    required Widget Function(Category) displayWidgetForOption,
    OptionsViewOpenDirection openDirection = OptionsViewOpenDirection.down,
    double maxOptionsHeight = 200
  }
) => (
  BuildContext context,
  AutocompleteOnSelected<Category> onSelected,
  Iterable<Category> options,
) => _AutocompleteOptions<Category>(
  displayWidgetForOption: displayWidgetForOption,
  onSelected: onSelected,
  options: options,
  openDirection: openDirection,
  maxOptionsHeight: maxOptionsHeight,
);
