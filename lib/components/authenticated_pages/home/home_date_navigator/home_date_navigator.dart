import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/texts/body_text.dart';

class HomeDateNavigator extends StatelessWidget {
  final MonthAndYear monthAndYear;
  final void Function(MonthAndYear) onChange;

  const HomeDateNavigator({
    super.key,
    required this.monthAndYear,
    required this.onChange,
  });

  List<Widget> getMonthAndDates() {
    return [
      TextButton(onPressed: () {}, child: BodyText('Sep 2024')),
      TextButton(onPressed: () {}, child: BodyText('Oct ${monthAndYear.year}')),
      TextButton(onPressed: () {}, child: BodyText('Nov 2024')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_left)),
        ...getMonthAndDates(),
        IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right)),
      ],
    );
  }
}
