import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/components/common/rounded_list_tile.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/color_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/services/category_service.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  List<Category> _categories = [];
  bool _isLoading = true;
  String? _search;
  StreamSubscription<List<Category>>? watcher;

  void _loadCategories() {
    watcher = CategoryService().watchCategories(search: _search)
      .listen((categories) =>
        setState(() {
          _categories = categories;
          _isLoading = false;
        })
      );
  }

  @override
  void dispose() {
    watcher?.cancel();
    watcher = null;
    
    super.dispose();
  }
  
  @override
  void initState() {
    _loadCategories();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: LocalizationHelper.localization(context).categories,
      body: _isLoading
        ? CircularProgressIndicator()
        : ListView.builder(
          itemCount: _categories.length,
          itemBuilder: (context, index) {
            var category = _categories[index];
            var categoryColor = category.color.withAlpha(60);
            var textColor = getTextColor(categoryColor);
            
            return RoundedListTile(
              backgroundColor: categoryColor,
              textColor: textColor,
              title: category.description,
              leading: Icon(category.icon.iconData, color: textColor),
              withCard: true,
              onTap: () => NavigatorHelper.pushNamed(
                context,
                RoutesNames.categoriesEdit,
                arguments: category.id,
              ),
            );
          }
        ),
      actions: [
        GoHomeAction(),
        IconButton(
          onPressed: () => NavigatorHelper.pushNamed(
            context,
            RoutesNames.categoriesCreate,
            arguments: RoutesNames.categories
          ),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }
}