import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hogastos/models/settings.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);


const _biometricAuthKey = 'biometric-auth';

class _SettingsCreator {
  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<bool> getBiometricAuth() async {
    var isEnabledString = await storage.read(key: _biometricAuthKey);

    return isEnabledString == null
      ? false
      : bool.parse(isEnabledString);
  }

  static Future<void> saveBiometricAuth(bool isEnabled) async {
    await storage.write(key: _biometricAuthKey, value: isEnabled.toString());
  }
}

class UserSettings {
  static final UserSettings _singleton = UserSettings._internal();
  factory UserSettings() => _singleton;
  UserSettings._internal();

  Settings? settings;

  Future<Settings> getUserSettings() async {
    settings ??= Settings(
      isBiometricAuthEnabled: await _SettingsCreator.getBiometricAuth(),
    );

    return settings!;
  }

  Future<void> saveBiometricAuth(bool isEnabled) async {
    _SettingsCreator.saveBiometricAuth(isEnabled);
  }
}