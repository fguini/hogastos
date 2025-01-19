import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/categories/categories_form/categories_form.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/create_category.dart';
import 'package:hogastos/services/category_service.dart';

class CategoriesCreate extends StatefulWidget {
  const CategoriesCreate({super.key});

  @override
  State<CategoriesCreate> createState() => _CategoriesCreateState();
}

class _CategoriesCreateState extends State<CategoriesCreate> {
  bool _isLoading = false;

  void _handleCreate(CreateCategory category, String? comingFrom) {
    setState(() {
      _isLoading = true;
    });

    CategoryService().createCategory(category)
      .then((category) => comingFrom != null
        ? NavigatorHelper.pop(
          context,
          result: category.id
        )
        : NavigatorHelper.pushNamedAndRemoveUntil(
          context,
          RoutesNames.home
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    var comingFrom = ModalRoute.of(context)!.settings.arguments as String?;

    return PageWithMenu(
      title: LocalizationHelper.localization(context).newCategory,
      body: CategoriesForm(
        isLoading: _isLoading,
        onSave: (category) => _handleCreate(category, comingFrom),
      ),
      actions: [
        GoHomeAction(popUntilHome: comingFrom == null),
      ],
    );
  }
}
