import 'package:flutter/material.dart';
import 'package:hogastos/components/animations/dialog_transition.dart';
import 'package:hogastos/models/dates/month_and_year.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_form.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/configurations/user_settings.dart';
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
  bool _isReady = false;
  Category? _preselectedCategory;
  DateTime _initialDate = DateTime.now();

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

    CategoryService().getById(categoryId).then((category) {
      NavigatorHelper.pop(context);

      setState(() {
        _preselectedCategory = category;
        _isLoading = false;
        _isReady = true;
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
            _isReady = true;
          });
        }
      }
    );
  }

  Future<void> _setInitialDate() {
    return UserSettings().getUserSettings().then((settings) {
      var nowMonthAndYear = MonthAndYear.now();
      var currentMonthAndYear = settings.monthAndYearInHome;
      var isSame = currentMonthAndYear.equals(nowMonthAndYear);

      if(!isSame) {
        setState(() {
          var weAreOnFuture = currentMonthAndYear.isFutureThan(nowMonthAndYear);
          var monthModifier = weAreOnFuture ? 0 : 1;
          var dayOfMonth = weAreOnFuture ? 1 : 0;

          _initialDate = DateTime(
            currentMonthAndYear.year,
            currentMonthAndYear.monthNumber + monthModifier,
            dayOfMonth,
          );
        });
      }
    });
  }

  @override
  void initState() {
    _setInitialDate().then((_) {
      _anyCategoryCreated();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: LocalizationHelper.localization(context).newMovement,
      body: _isReady
        ? MovementsForm(
          initialDate: _initialDate,
          preselectedCategory: _preselectedCategory,
          isLoading: _isLoading,
          onSave: _handleCreate
        )
        : CircularProgressIndicator(),
      leading: GoHomeAction(popUntilHome: true),
    );
  }
}
