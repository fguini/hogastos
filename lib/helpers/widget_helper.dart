import 'package:flutter/material.dart';

class WidgetHelper {
  static List<Widget> conditionalWidgetToSpread(bool condition, Widget widget) => condition
    ? [ widget ]
    : [];
}
