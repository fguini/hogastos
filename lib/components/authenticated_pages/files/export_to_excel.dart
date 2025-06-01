import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/home/home_date_navigator/month_and_year.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/components/common/rounded_list_tile.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/services/excel_service.dart';
import 'package:hogastos/services/movement_service.dart';

class ExportToExcel extends StatefulWidget {
  const ExportToExcel({super.key});

  @override
  State<ExportToExcel> createState() => _ExportToExcelState();
}

class _ExportToExcelState extends State<ExportToExcel> {
  bool _allMonths = true;
  String? _errorMessage;
  bool _isLoading = true;
  List<MonthAndYear> _monthAndYears = [];
  final List<MonthAndYear> _selectedMonthAndYears = [];

  void _getMonthAndYears() async {
    MovementService().getMovementsMonthAndYear().then((newMonthAndYears) => setState(() {
      _isLoading = false;
      _monthAndYears = newMonthAndYears;
    }));
  }

  @override
  void initState() {
    _getMonthAndYears();

    super.initState();
  }

  void _handleAllMonthsChange(bool newValue) => setState(() {
    setState(() {
      _errorMessage = null;
    });
    _allMonths = newValue;
  });

  void _handleMonthAndYearTap(MonthAndYear monthAndYear) => setState(() {
    _errorMessage = null;
    if(_selectedMonthAndYears.contains(monthAndYear)) {
      _selectedMonthAndYears.remove(monthAndYear);
    } else {
      _selectedMonthAndYears.add(monthAndYear);
    }
  });

  void _handleExport() {
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });

    var monthsAndYears = _allMonths
      ? _monthAndYears
      : _selectedMonthAndYears;

    ExcelService().exportToExcel(monthsAndYears, context: context)
      .then((_) {
        if(context.mounted) {
          ScaffoldMessenger
            .of(context)
            .showSnackBar(
              SnackBar(
                content: Text(
                  LocalizationHelper.localization(context).exportToExcelSuccess
                )
              )
            );
        }
      })
      .onError((Exception error, _) {
        setState(() {
          _errorMessage = error.toString();
        });
      })
      .whenComplete(() => setState(() {
        _isLoading = false;
      }));
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
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      BodyText(localization.exportToExcelAllMonths),
                      Switch(
                        value: _allMonths,
                        onChanged: _isLoading
                          ? null
                          : _handleAllMonthsChange,
                      )
                    ],
                  ),
                  ..._allMonths ? [] : [
                    Expanded(child: ListView.builder(
                      itemCount: _monthAndYears.length,
                      itemBuilder: (context, index) {
                        var monthAndYear = _monthAndYears[index];

                        return RoundedListTile(
                          title: monthAndYear.locale(context),
                          leading: Icon(
                            _selectedMonthAndYears.contains(monthAndYear)
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank,
                          ),
                          onTap: () => _handleMonthAndYearTap(monthAndYear),
                        );
                      }
                    ))
                  ]
                ],
              ),
            ),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._errorMessage != null
                    ? [ BodyText(_errorMessage!, color: Colors.red) ]
                    : [],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                        ? null
                        : _handleExport,
                      child: Text(localization.exportToExcelExport),
                    ),
                  )
                ],
              )
            ),
          ],
        ),
      ),
      leading: GoHomeAction(popUntilHome: true),
    );
  }
}
