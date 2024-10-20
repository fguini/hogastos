import 'package:flutter/material.dart';

class NavigatorHelper {
  static Future<T?> pushNamed<T extends Object>(
    BuildContext context,
    String routeName,
    { Object? arguments }
  ) {
    if(context.mounted) {
      return Navigator.of(context).pushNamed(routeName, arguments: arguments);
    }

    return Future.value(null);
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object>(
    BuildContext context,
    String routeName,
    {
      bool Function(Route<dynamic>)? predicate,
      Object? arguments,
    }
  ) {
    if(context.mounted) {
      return Navigator.of(context).pushNamedAndRemoveUntil(
        routeName,
        predicate ?? (_) => false,
        arguments: arguments
      );
    }

    return Future.value(null);
  }
}