import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/texts/body_text.dart';

class HomeDateNavigator extends StatefulWidget {
  final MonthAndYear monthAndYear;
  final void Function(MonthAndYear) onChange;

  const HomeDateNavigator({
    super.key,
    required this.monthAndYear,
    required this.onChange,
  });

  @override
  State<HomeDateNavigator> createState() => _HomeDateNavigatorState();
}

class _HomeDateNavigatorState extends State<HomeDateNavigator> {
  List<MonthAndYear> monthAndYears = [];

  void _setMonthAndYears(MonthAndYear center) {
    setState(() {
      monthAndYears = [
        center.getPrevious(),
        center,
        center.getNext(),
      ];
    });
  }

  void _initMonthAndYears() => _setMonthAndYears(widget.monthAndYear);
  void _handlePrevious() => _setMonthAndYears(monthAndYears.first);
  void _handleNext() => _setMonthAndYears(monthAndYears.last);

  @override
  void initState() {
    _initMonthAndYears();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: _handlePrevious, icon: Icon(Icons.arrow_left)),
        ...monthAndYears
          .map((monthAndYear) => TextButton(
            onPressed: () => widget.onChange(monthAndYear),
            child: BodyText(
              monthAndYear.locale(context),
              color: monthAndYear.equals(widget.monthAndYear)
                ? theme.primaryColorDark
                : Colors.black54,
            ),
          )),
        IconButton(onPressed: _handleNext, icon: Icon(Icons.arrow_right)),
      ],
    );
  }
}
