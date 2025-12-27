import 'package:flutter/material.dart';
import 'package:hogastos/components/animations/dialog_transition.dart';
import 'package:hogastos/components/texts/body_text.dart';
import 'package:hogastos/configurations/authentication.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:hogastos/models/user.dart';

class _Menu extends StatefulWidget {
  const _Menu();

  @override
  State<_Menu> createState() => _MenuState();
}

class _MenuState extends State<_Menu> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var localization = LocalizationHelper.localization(context);

    return Dialog(
      child: Container(
        padding: theme.inputDecorationTheme.contentPadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BodyText(localization.appTitle),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BodyText(localization.settingsTheme),
                SegmentedButton(
                  segments: [
                    ButtonSegment(value: 1, icon: Icon(Icons.dark_mode)),
                    ButtonSegment(value: 2, icon: Icon(Icons.light_mode)),
                    ButtonSegment(value: 3, icon: Icon(Icons.auto_awesome)),
                  ],
                  selected: {1},
                  showSelectedIcon: false,
                  onSelectionChanged: (val) {},
                  style: ButtonStyle(
                    iconSize: WidgetStatePropertyAll(10),
                    maximumSize: WidgetStatePropertyAll(Size.square(5)),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(1))
                  ),
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      AuthState().logout().then((_) {
                        NavigatorHelper.pushNamedAndRemoveUntil(
                          context,
                          RoutesNames.authCreate,
                        );
                      });
                    },
                    child: BodyText(localization.actionsLogout),
                  ),
                ),
              ],
            )
          ],
        ),
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
