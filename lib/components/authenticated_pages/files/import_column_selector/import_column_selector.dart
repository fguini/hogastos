import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/files/import_column_selector/column_data_selector.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/components/texts/hint_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/excel_column_definition.dart';
import 'package:hogastos/models/excel_import_brief.dart';

import 'column_selection.dart';

class ImportColumnSelector extends StatelessWidget {
  final ExcelImportBrief? file;
  final Map<String, ColumnSelection>? columnSelection;
  final void Function(String, Map<String, ExcelColumnDefinition?>) onColumnSelectionChanged;
  final void Function(String, bool) onHasHeaderChanged;
  final void Function(String) onHandleApplyToAll;

  const ImportColumnSelector({
    super.key,
    this.file,
    required this.columnSelection,
    required this.onColumnSelectionChanged,
    required this.onHasHeaderChanged,
    required this.onHandleApplyToAll,
  });

  _handleColumnSelectionChange(String table)
    => (Map<String, ExcelColumnDefinition?> newColumnSelection)
      => onColumnSelectionChanged(table, newColumnSelection);

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);
    var theme = Theme.of(context);

    if(columnSelection == null) {
      return HintText(localization.importFromExcelSelectFile);
    }

    var tableList = columnSelection!.keys.toList();

    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 800,
                viewportFraction: 1,
                autoPlay: false,
                enableInfiniteScroll: false,
              ),
              items: tableList.map((table) {
                var tableColumns = columnSelection![table]!;
                var tableIndex = tableList.indexOf(table);
                var isFirstOne = tableIndex == 0;
                var isLastOne = tableIndex == (tableList.length - 1);

                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: 800,
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          ...!isLastOne ? [
                            BoxShadow(
                              color: theme.primaryColor,
                              offset: Offset.fromDirection(2.9),
                              blurRadius: 10,
                              blurStyle: BlurStyle.outer,
                            )
                          ] : [],
                          ...!isFirstOne ? [
                            BoxShadow(
                              color: theme.primaryColor,
                              offset: Offset.fromDirection(0.2),
                              blurRadius: 1,
                              blurStyle: BlurStyle.outer,
                            )
                          ] : [],
                        ]
                      ),
                      child: Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SubtitleText(table),
                                IconButton(
                                  icon: Icon(
                                    Icons.done_all,
                                    color: theme.primaryColor,
                                  ),
                                  onPressed: () => onHandleApplyToAll(table),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BodyText(localization.importFromExcelHasHeaders),
                                Switch(
                                  value: tableColumns.hasHeadersRow,
                                  onChanged: (newValue) => onHasHeaderChanged(
                                    table,
                                    newValue,
                                  ),
                                ),
                              ],
                            ),
                            ColumnDataSelector(
                              columnSelection: tableColumns.columnSelection,
                              onColumnSelectionChanged: _handleColumnSelectionChange(table),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
