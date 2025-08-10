import 'package:flutter/material.dart';
import 'package:hogastos/models/dates/navigable_date.dart';

class NavigableYear extends NavigableDate {
  final int value;

  NavigableYear({ required this.value });
  factory NavigableYear.now() => NavigableYear(value: DateTime.now().year);

  @override
  bool equals(NavigableDate other) => (other as NavigableYear).value == value;

  @override
  NavigableYear getNext() => NavigableYear(value: value + 1);

  @override
  NavigableDate getPrevious() => NavigableYear(value: value - 1);

  @override
  String locale(BuildContext context) => value.toString();
}