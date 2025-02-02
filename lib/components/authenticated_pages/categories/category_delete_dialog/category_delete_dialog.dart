import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/category_selector/category_selector.dart';
import 'package:hogastos/components/common/error_elevated_button.dart';
import 'package:hogastos/components/texts/hint_text.dart';
import 'package:hogastos/components/texts/subtitle_text.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/category.dart';

class CategoryDeleteDialog extends StatefulWidget {
  final void Function(int?) onConfirm;

  const CategoryDeleteDialog({
    super.key,
    required this.onConfirm,
  });

  @override
  State<CategoryDeleteDialog> createState() => _CategoryDeleteDialogState();
}

class _CategoryDeleteDialogState extends State<CategoryDeleteDialog> {
  int? _categoryId;
  
  void _handleCategoryChanged(Category category) {
    setState(() {
      _categoryId = category.id;
    });
  }

  void _handleConfirm() {
    widget.onConfirm(_categoryId);
  }

  @override
  Widget build(BuildContext context) {
    var localization = LocalizationHelper.localization(context);

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 6),
                child: SubtitleText(localization.categoryDeleteTitle),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: HintText(localization.categoryDeleteDescription),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: CategorySelector(onCategoryChanged: _handleCategoryChanged),
              ),
              SizedBox(
                width: double.infinity,
                child: ErrorElevatedButton(
                  onPressed: _handleConfirm,
                  child: Text(localization.actionsDelete),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
