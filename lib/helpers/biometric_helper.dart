import 'package:flutter/services.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';

class BiometricHelper {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> isBiometricAuthAvailable() async {
    var canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    return canAuthenticateWithBiometrics
        || await auth.isDeviceSupported();
  }

  static Future<bool> authenticate(
    Localization localization
  ) async {
    try {
      return await auth.authenticate(
        localizedReason: localization.biometricAuthReason,
        authMessages: [
          AndroidAuthMessages(
            biometricHint: localization.biometricAuthBiometricHint,
            biometricNotRecognized: localization.biometricAuthBiometricNotRecognized,
            biometricRequiredTitle: localization.biometricAuthBiometricRequiredTitle,
            biometricSuccess: localization.biometricAuthBiometricSuccess,
            cancelButton: localization.biometricAuthCancelButton,
            deviceCredentialsRequiredTitle: localization.biometricAuthDeviceCredentialsRequiredTitle,
            deviceCredentialsSetupDescription: localization.biometricAuthDeviceCredentialsSetupDescription,
            goToSettingsButton: localization.biometricAuthGoToSettingsButton,
            goToSettingsDescription: localization.biometricAuthGoToSettingsDescription,
            signInTitle: localization.biometricAuthSignInTitle,
          ),
        ],
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } on PlatformException {
      rethrow;
      // TODO handle error
    }
  }
}