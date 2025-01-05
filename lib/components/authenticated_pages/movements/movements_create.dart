import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/authenticated_pages/home/home_layout.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_form.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';

class MovementsCreate extends StatelessWidget {
  const MovementsCreate({super.key});

  void _handleCreate(Item movement) {
    print(movement.text);
  }

  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: AppLocalizations.of(context)!.newMovement,
      body: MovementsForm(
        onSave: _handleCreate
      ),
      actions: [
        GoHomeAction(popUntilHome: true),
      ],
    );
  }
}
