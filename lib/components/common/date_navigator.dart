import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/models/dates/navigable_date.dart';

class DateNavigator<TDate extends NavigableDate> extends StatefulWidget {
  final TDate value;
  final void Function(TDate) onChange;

  const DateNavigator({
    super.key,
    required this.value,
    required this.onChange,
  });

  @override
  State<DateNavigator> createState() => _DateNavigatorState();
}

class _DateNavigatorState<TDate extends NavigableDate> extends State<DateNavigator<TDate>> {
  List<TDate> dates = [];

  void _setDate(TDate center) {
    setState(() {
      dates = [
        center.getPrevious() as TDate,
        center,
        center.getNext() as TDate,
      ];
    });
  }

  void _initDate() => _setDate(widget.value);
  void _handlePrevious() => _setDate(dates.first);
  void _handleNext() => _setDate(dates.last);

  @override
  void didUpdateWidget(covariant DateNavigator<TDate> oldWidget) {
    if(!oldWidget.value.equals(widget.value)) {
      _initDate();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _initDate();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: _handlePrevious, icon: Icon(Icons.arrow_left)),
        ...dates
          .map((TDate date) => TextButton(
            onPressed: () => widget.onChange(date),
            child: BodyText(
              date.locale(context),
              color: date.equals(widget.value)
                ? theme.colorScheme.brightness == Brightness.dark
                    ? theme.primaryColorLight
                    : theme.primaryColorDark
                : getDefaultThemeTextColor(theme),
            ),
          )),
        IconButton(onPressed: _handleNext, icon: Icon(Icons.arrow_right)),
      ],
    );
  }
}
