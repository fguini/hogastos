import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';

class ExportToExcel extends StatefulWidget {
  const ExportToExcel({super.key});

  @override
  State<ExportToExcel> createState() => _ExportToExcelState();
}

class _ExportToExcelState extends State<ExportToExcel> {
  bool _allMonths = true;
  List<MonthAndYear> selectedMonthAndYears = [];

  void _handleAllMonthsChange(bool newValue) => setState(() {
    _allMonths = newValue;
  });

  void _handleExport() {

  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return PageWithMenu(
      title: localization.exportToExcel,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                BodyText(localization.exportToExcelAllMonths),
                Switch(value: _allMonths, onChanged: _handleAllMonthsChange)
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleExport,
                child: Text(localization.exportToExcelExport),
              ),
            ),
          ],
        ),
      ),
      leading: GoHomeAction(popUntilHome: true),
    );
  }
}
