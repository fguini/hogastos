import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/categories/categories_form/categories_form.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_category.dart';
import 'package:hogastos/services/category_service.dart';

class CategoriesEdit extends StatelessWidget {
  const CategoriesEdit({super.key});

  @override
  Widget build(BuildContext context) {
    var categoryId = ModalRoute.of(context)!.settings.arguments;

    return _CategoriesEditController(
      categoryId: categoryId as int,
    );
  }
}

class _CategoriesEditController extends StatefulWidget {
  final int categoryId;

  const _CategoriesEditController({required this.categoryId});

  @override
  State<_CategoriesEditController> createState() => _CategoriesEditControllerState();
}

class _CategoriesEditControllerState extends State<_CategoriesEditController> {
  bool _isLoading = true;
  Category? _category;

  void _loadCategory() {
    CategoryService().getById(widget.categoryId).then((category) => setState(() {
      _category = category;
      _isLoading = false;
    }));
  }

  void _handleUpdate(CreateCategory category) {
    setState(() {
      _isLoading = true;
    });

    CategoryService().updateCategory(category as Category)
      .then((category) => NavigatorHelper.pop(
        context,
        result: category.id
      ));
  }

  @override
  void initState() {
    _loadCategory();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading) {
      return CircularProgressIndicator();
    }

    return PageWithMenu(
      title: LocalizationHelper.localization(context).newCategory,
      body: CategoriesForm(
        initialCategory: _category,
        isLoading: _isLoading,
        onSave: (category) => _handleUpdate(category),
      ),
      actions: [
        GoHomeAction(popUntilHome: false),
      ],
    );
  }
}
