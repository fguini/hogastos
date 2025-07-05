import 'package:flutter/material.dart';
import 'package:hogastos/components/animations/dialog_transition.dart';
import 'package:hogastos/components/authenticated_pages/files/import_column_selector/import_column_selector.dart';
import 'package:hogastos/components/authenticated_pages/files/import_preview_dialog/import_preview_dialog.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_movement.dart';
import 'package:hogastos/models/excel_column_definition.dart';
import 'package:hogastos/models/excel_import_brief.dart';
import 'package:hogastos/services/excel_service.dart';

import 'import_column_selector/column_selection.dart';

class ImportFromExcel extends StatefulWidget {
  const ImportFromExcel({super.key});

  @override
  State<ImportFromExcel> createState() => _ImportFromExcelState();
}

class _ImportFromExcelState extends State<ImportFromExcel> {
  String? _errorMessage;
  ExcelImportBrief? _file;
  Map<String, ColumnSelection>? _columnSelection;
  bool _isLoading = false;

  void _initColumnSelection() {
    if(_file == null) {
      return setState(() {
        _columnSelection = null;
      });
    }

    Map<String, ColumnSelection> newColumnSelection = {};

    for (var table in _file!.tables) {
      Map<String, ExcelColumnDefinition?> columns = {};

      for(var column in table.columns) {
        columns[column.columnName] = ExcelColumnDefinition
          .values
          .elementAtOrNull(table.columns.indexOf(column));
      }

      newColumnSelection[table.tableName] = ColumnSelection(
        hasHeadersRow: true,
        columnSelection: columns
      );
    }

    setState(() {
      _columnSelection = newColumnSelection;
    });
  }

  void _handleFilePick() {
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
      .whenComplete(() {
        setState(() {
          _isLoading = false;
        });
        _initColumnSelection();
      });
  }

  void _handleHasHeaderChanged(String table, bool newHasHeaders) {
    setState(() {
      _columnSelection![table]!.hasHeadersRow = newHasHeaders;
    });
  }

  void _handleColumnSelectionChanged(String table, Map<String, ExcelColumnDefinition?> newColumnSelection) => setState(() {
    _columnSelection![table]!.columnSelection = newColumnSelection;
  });

  void _handleApplyToAll(String tableToCopy) {
    var dataToCopy = _columnSelection![tableToCopy]!;

    setState(() {
      for(var table in _columnSelection!.keys) {
        _columnSelection![table] = dataToCopy;
      }
    });
  }

  void _handleImport(List<CreateMovement> movements, List<Category> categories) {
    setState(() {
      _isLoading = true;
    });

    ExcelService().import(movements, categories)
      .onError((exception, _) => setState(() {
        _errorMessage = exception.toString();
      }))
      .whenComplete(() {
        NavigatorHelper.pop(context);
      });
  }

  void _handleOpenPreview() {
    setState(() {
      _isLoading = true;
    });

    ExcelService().getMovementsAndCategoriesFromExcel(
      _file!,
      _columnSelection!,
      LocalizationHelper.localization(context).localeName
    ).then((result) {
        if(!context.mounted) return;

        var (movements, categories) = result;

        onClose() {
          NavigatorHelper.pop(context);
        }
        onImport() {
          onClose();

          _handleImport(movements, categories);
        }

        DialogTransition.open(
          context,
          ImportPreviewDialog(
            categories: categories,
            movements: movements,
            onClose: onClose,
            onImport: onImport,
          ),
        );
      })
      .onError((exception, _) {
        setState(() {
          _errorMessage = exception.toString();
        });
      })
      .whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
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
            Flexible( // TODO fix layout
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading
                        ? null
                        : _handleFilePick,
                      child: Text(localization.importFromExcelPickFile),
                    ),
                  ),
                  ImportColumnSelector(
                    file: _file,
                    columnSelection: _columnSelection,
                    onColumnSelectionChanged: _handleColumnSelectionChanged,
                    onHasHeaderChanged: _handleHasHeaderChanged,
                    onHandleApplyToAll: _handleApplyToAll,
                  )
                ],
              ),
            ),
            Column(
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
                      : _handleOpenPreview,
                    child: Text(localization.importFromExcelPreview),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      leading: GoHomeAction(popUntilHome: true),
    );
  }
}
