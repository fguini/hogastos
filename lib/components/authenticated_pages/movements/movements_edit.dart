import 'package:flutter/material.dart';
import 'package:hogastos/components/authenticated_pages/movements/movements_form/movements_form.dart';
import 'package:hogastos/components/authenticated_pages/page_with_menu.dart';
import 'package:hogastos/components/common/go_home_action.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/create_movement.dart';
import 'package:hogastos/models/movement.dart';
import 'package:hogastos/services/movement_service.dart';

class MovementsEdit extends StatelessWidget {
  const MovementsEdit({super.key});

  @override
  Widget build(BuildContext context) {
    var movementId = ModalRoute.of(context)!.settings.arguments as int;

    return _MovementsEditController(
      movementId: movementId,
    );
  }
}

class _MovementsEditController extends StatefulWidget {
  final int movementId;

  const _MovementsEditController({required this.movementId});

  @override
  State<_MovementsEditController> createState() => _MovementsEditControllerState();
}

class _MovementsEditControllerState extends State<_MovementsEditController> {
  bool _isMovementLoading = true;
  bool _isLoading = false;
  Movement? _movement;

  void _loadMovement() {
    setState(() {
      _isMovementLoading = true;
    });

    MovementService().getById(widget.movementId).then(
      (movement) => setState(() {
        _movement = movement;
        _isMovementLoading = false;
      })
    );
  }

  void _handleUpdate(CreateMovement movement) {
    setState(() {
      _isLoading = true;
    });

    MovementService().updateMovement(movement as Movement)
      .then((_) => NavigatorHelper.pushNamedAndRemoveUntil(
        context,
        RoutesNames.home
      ));
  }

  void _handleDelete(int id) {
    setState(() {
      _isLoading = true;
    });

    MovementService().deleteMovement(id)
      .then((_) => NavigatorHelper.pushNamedAndRemoveUntil(
        context,
        RoutesNames.home
      ));
  }

  @override
  void initState() {
    _loadMovement();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageWithMenu(
      title: LocalizationHelper.localization(context).newMovement,
      body: _isMovementLoading
        ? CircularProgressIndicator()
        : MovementsForm(
          initialMovement: _movement,
          isLoading: _isLoading,
          onDelete: _handleDelete,
          onSave: _handleUpdate,
        ),
      actions: [
        GoHomeAction(popUntilHome: true),
      ],
    );
  }
}
