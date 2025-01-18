import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/animations/dialog_transition.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_form.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/services/category_service.dart';

import 'no_categories_created_dialog/no_categories_created_dialog.dart';

class MovementsCreate extends StatefulWidget {
  const MovementsCreate({super.key});

  @override
  State<MovementsCreate> createState() => _MovementsCreateState();
}

class _MovementsCreateState extends State<MovementsCreate> {
  bool _isLoading = true;

  void _handleCreate(Movement movement) {
    print(movement.text);
  }

  void _anyCategoryCreated() {
    CategoryService().existAnyCategory().then(
      (bool exists) {
        if(!exists) {
          DialogTransition.open(
            context,
            NoCategoriesCreatedDialog(),
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

  // TODO on load, should check if any category available and if not show a dialog to redirect to category creation
  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: LocalizationHelper.localization(context).newMovement,
      body: MovementsForm(
        isLoading: _isLoading,
        onSave: _handleCreate
      ),
      actions: [
        GoHomeAction(popUntilHome: true),
      ],
    );
  }
}
