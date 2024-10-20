import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/animations/dialog_transition.dart';
import 'package:hogastos/configurations/authentication.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/user.dart';

class _Menu extends StatefulWidget {
  const _Menu({super.key});

  @override
  State<_Menu> createState() => _MenuState();
}

class _MenuState extends State<_Menu> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Meme'), // TODO show user info
          Divider(),
          ElevatedButton(
            onPressed: () {
              AuthState().logout().then((_) {
                NavigatorHelper.pushNamedAndRemoveUntil(
                  context,
                  RoutesNames.authCreate,
                );
              });
            },
            child: Text(
              AppLocalizations.of(context)!.actionsLogout,
            ),
          ),
        ],
      ),
    );
  }
}

class AvatarIcon extends StatelessWidget {
  final User user;

  const AvatarIcon({
    super.key,
    required this.user
  });

  void handleOpenMenu(BuildContext context) {
    DialogTransition.open(
      context,
      _Menu(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: IconButton(
        icon: Icon(Icons.circle),
        onPressed: () => handleOpenMenu(context),
      ),
    );
  }
}
