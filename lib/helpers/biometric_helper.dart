import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class BiometricHelper {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> isBiometricAuthAvailable() async {
    var canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    return canAuthenticateWithBiometrics
        || await auth.isDeviceSupported();
  }

  static Future<bool> authenticate(String localizedReason) async {
    try {
      return await auth.authenticate(
        localizedReason: localizedReason,
        options: const AuthenticationOptions(biometricOnly: true),
      ); // TODO translate default messages
    } on PlatformException {
      rethrow;
      // TODO handle error
    }
  }
}