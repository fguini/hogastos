import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/excel_import_brief.dart';
import 'package:hogastos/services/excel_service.dart';

class ImportFromExcel extends StatefulWidget {
  const ImportFromExcel({super.key});

  @override
  State<ImportFromExcel> createState() => _ImportFromExcelState();
}

class _ImportFromExcelState extends State<ImportFromExcel> {
  String? _errorMessage;
  ExcelImportBrief? _file;
  bool _isLoading = false;

  void handleFilePick() {
    setState(() {
      _isLoading = true;
    });

    ExcelService().pickFileAndOpen()
      .then((excelBrief) => setState(() {
        _file = excelBrief;
      }))
      .onError((exception, _) => setState(() {
        _errorMessage = exception.toString();
      }))
      .whenComplete(() => setState(() {
        _isLoading = false;
      }));
  }

  void _handleImport() {

  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return PageWithMenu(
      title: localization.importFromExcel,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                        ? null
                        : handleFilePick,
                      child: Text(localization.importFromExcelPickFile),
                    ),
                  ),
                  ..._file == null
                    ? []
                    : [
                      BodyText('Cantidad tablas: ${_file!.sheets.count}'),
                      BodyText('Cantidad filas: ${_file!.rows.count}'),
                      BodyText('Cantidad columnas: ${_file!.columns.count}'),
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
                      onPressed: _isLoading || _file == null
                        ? null
                        : _handleImport,
                      child: Text(localization.importFromExcelImport),
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
