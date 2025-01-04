import 'package:flutter/material.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/navigator_helper.dart';

class GoHomeAction extends StatelessWidget {
  final bool popUntilHome;

  const GoHomeAction({
    super.key,
    this.popUntilHome = false,
  });

  void _handleGoHome(BuildContext context) {
    if(popUntilHome) {
      NavigatorHelper.popUntil(context, RoutesNames.home);
    } else {
      NavigatorHelper.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => _handleGoHome(context),
      icon: Icon(Icons.arrow_back),
    );
  }
}
