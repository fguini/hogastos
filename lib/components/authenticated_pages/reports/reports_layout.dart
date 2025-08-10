import 'package:flutter/material.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';

class ReportsLayout<TData> extends StatelessWidget {
  final bool isLoading;
  final List<TData> items;
  final Widget child;

  const ReportsLayout({
    super.key,
    required this.isLoading,
    required this.items,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    if(!isLoading && items.isEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ BodyText(localization.reportsNoData) ],
      );
    }

    return child;
  }
}
