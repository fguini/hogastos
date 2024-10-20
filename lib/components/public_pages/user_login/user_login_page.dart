import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hogastos/components/public_pages/page_without_appbar.dart';
import 'package:hogastos/configurations/authentication.dart';
import 'package:hogastos/configurations/routes.dart';
import 'package:hogastos/constants/pin_length.dart';
import 'package:hogastos/helpers/navigator_helper.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  bool _isLoading = false;
  final TextEditingController pinController = TextEditingController();

  void handlePinLogin() {
    setState(() {
      _isLoading = true;
    });

    AuthState().login(pinController.text)
      .then((_) {
        // TODO open access with biometrics modal and redirect
        NavigatorHelper.pushNamedAndRemoveUntil(
          context,
          RoutesNames.home,
        );
      })
      .onError((_, __) {
        setState(() {
          _isLoading = false;
        });
        // TODO handle error
      });
  }

  void initBiometricLogin(BuildContext context) async {
    if(!context.mounted) return;

    var reason = AppLocalizations.of(context)!.actionsLocalAuth;
    var isAuthenticated = await AuthState().localLogin(reason);

    if (isAuthenticated) {
      NavigatorHelper.pushNamedAndRemoveUntil(context, RoutesNames.home);
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => initBiometricLogin(context)
    );
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
            obscureText: true,
            obscuringCharacter: '*',
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
            onCompleted: (_) => handlePinLogin()
          ),
          ElevatedButton(
            onPressed: _isLoading ? null : handlePinLogin,
            child: Text(AppLocalizations.of(context)!.actionsLogin),
          ),
          IconButton(
            onPressed: () => initBiometricLogin(context),
            icon: Icon(
              Icons.remove_red_eye_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
