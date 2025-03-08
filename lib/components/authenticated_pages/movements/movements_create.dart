import 'package:flutter/material.dart';
import 'package:hogastos/components/animations/dialog_transition.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_form.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/category.dart';
import 'package:hogastos/models/create_movement.dart';
import 'package:hogastos/services/category_service.dart';
import 'package:hogastos/services/movement_service.dart';

import 'no_categories_created_dialog/no_categories_created_dialog.dart';

class MovementsCreate extends StatefulWidget {
  const MovementsCreate({super.key});

  @override
  State<MovementsCreate> createState() => _MovementsCreateState();
}

class _MovementsCreateState extends State<MovementsCreate> {
  bool _isLoading = true;
  Category? _preselectedCategory;

  void _handleCreate(CreateMovement movement) {
    setState(() {
      _isLoading = true;
    });

    MovementService().createMovement(movement)
      .then((_) => NavigatorHelper.pushNamedAndRemoveUntil(
        context,
        RoutesNames.home
      ));
  }

  void _handlePopWithCategory(int? categoryId) {
    if(categoryId == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    CategoryService().getById(categoryId).then((category) {
      setState(() {
        _preselectedCategory = category;
        _isLoading = false;
      });
    });
  }

  void _anyCategoryCreated() {
    CategoryService().existAnyCategory().then(
      (bool exists) {
        if(!exists) {
          DialogTransition.open(
            context,
            NoCategoriesCreatedDialog(onPop: _handlePopWithCategory),
            barrierDismissible: false,
          );
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    );
  }

  @override
  void initState() {
    _anyCategoryCreated();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: LocalizationHelper.localization(context).newMovement,
      body: MovementsForm(
        preselectedCategory: _preselectedCategory,
        isLoading: _isLoading,
        onSave: _handleCreate
      ),
      leading: GoHomeAction(popUntilHome: true),
    );
  }
}
