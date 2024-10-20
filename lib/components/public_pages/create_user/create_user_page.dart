import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/animations/dialog_transition.dart';
import 'package:hogastos/components/public_pages/page_without_appbar.dart';
import 'package:hogastos/configurations/authentication.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/configurations/user_settings.dart';
import 'package:hogastos/constants/pin_length.dart';
import 'package:hogastos/helpers/biometric_helper.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class _EnableBiometricAuthDialog extends StatelessWidget {
  final VoidCallback onContinue;

  const _EnableBiometricAuthDialog({
    super.key,
    required this.onContinue,
  });

  void handleTap(bool isEnabled) => UserSettings()
    .saveBiometricAuth(isEnabled)
    .then((_) => onContinue());

  void handleReject() => handleTap(false);
  void handleConfirm() => handleTap(true);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('¿Quieres habilitar el acceso por biometría (huella dactilar o reconocimiento facial)?'), // TODO translate
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: handleReject,
                  child: Text('No'), // TODO translate
                ),
                SizedBox(width: 4),
                ElevatedButton(
                  onPressed: handleConfirm,
                  child: Text('Si'), // TODO translate
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  bool _isLoading = false;
  final TextEditingController pinController = TextEditingController();

  void handleCreated(VoidCallback onCreated) async {
    if (await BiometricHelper.isBiometricAuthAvailable()) {
      DialogTransition.open(
        context,
        _EnableBiometricAuthDialog(onContinue: onCreated)
      );
    } else {
      onCreated();
    }
  }

  void handleCreate() {
    setState(() {
      _isLoading = true;
    });

    AuthState().createUser(pinController.text)
      .then((_) {
        handleCreated(
          () => NavigatorHelper.pushNamedAndRemoveUntil(
            context,
            RoutesNames.home,
          ),
        );
      })
      .onError((_, __) {
        setState(() {
          _isLoading = false;
        });
        // TODO handle error
      });
  }

  @override
  Widget build(BuildContext context) {
    return PageWithoutAppbar(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.pageCreateUserTitle
          ),
          PinCodeTextField(
            appContext: context,
            length: pinLength,
            controller: pinController,
            enabled: !_isLoading,
            validator: (String? pin) {
              if (pin?.isEmpty ?? true) {
                return AppLocalizations.of(context)!.validationsIsRequired;
              }

              if (pin!.length < pinLength) {
                return AppLocalizations.of(context)!.validationsMinLength(
                  pinLength
                );
              }

              return null;
            },
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : handleCreate,
            child: Text(AppLocalizations.of(context)!.actionsCreate),
          ),
        ],
      ),
    );
  }
}
