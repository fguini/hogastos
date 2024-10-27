import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hogastos/models/settings.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);


const _biometricAuthKey = 'biometric-auth';
const _isGroupedListInHome = 'is-grouped-list-in-home';

class _SettingsCreator {
  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<bool> _getBooleanValue(String key) async {
    var value = await storage.read(key: key);

    return value == null
        ? false
        : bool.parse(value);
  }

  static Future<bool> getBiometricAuth() =>
    _getBooleanValue(_biometricAuthKey);
  static Future<bool> getIsGroupedListInHome() =>
    _getBooleanValue(_isGroupedListInHome);

  static Future<void> saveBiometricAuth(bool isEnabled) async =>
    await storage.write(key: _biometricAuthKey, value: isEnabled.toString());
  static Future<void> saveIsGroupedListInHome(bool isGrouped) async =>
    await storage.write(key: _isGroupedListInHome, value: isGrouped.toString());
}

class UserSettings {
  static final UserSettings _singleton = UserSettings._internal();
  factory UserSettings() => _singleton;
  UserSettings._internal();

  Settings? settings;

  Future<Settings> getUserSettings() async {
    settings ??= Settings(
      isBiometricAuthEnabled: await _SettingsCreator.getBiometricAuth(),
      isGroupedListInHome: await _SettingsCreator.getIsGroupedListInHome(),
    );

    return settings!;
  }

  Future<void> saveBiometricAuth(bool isEnabled) async {
    _SettingsCreator.saveBiometricAuth(isEnabled);
  }

  Future<void> saveIsGroupedListInHome(bool isGrouped) async {
    _SettingsCreator.saveIsGroupedListInHome(isGrouped);
  }
}