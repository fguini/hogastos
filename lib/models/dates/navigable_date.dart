import 'package:flutter/material.dart';

abstract class NavigableDate {
  NavigableDate getPrevious();
  NavigableDate getNext();

  bool equals(NavigableDate other);
  String locale(BuildContext context);
}