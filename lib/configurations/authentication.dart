import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hogastos/configurations/user_settings.dart';
import 'package:hogastos/helpers/biometric_helper.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:hogastos/models/user.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);

const _userTokenKey = 'user-token-key';

class _AuthCreator {
  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<String?> getUserToken() async {
    return await storage.read(key: _userTokenKey);
  }

  static Future<void> createUserToken(String userToken) async {
    await storage.write(key: _userTokenKey, value: userToken);
  }

  static Future<void> deleteUserToken() async {
    await storage.delete(key: _userTokenKey);
  }
}

class _AuthCrypto {
  static String encryptPin(String pin) {
    var bytes = utf8.encode(pin);
    var digest = sha1.convert(bytes);

    return digest.toString();
  }
}

class InvalidPinException implements Exception {
  final String message = 'Invalid pin value';
}

class AuthState {
  static final AuthState _singleton = AuthState._internal();
  factory AuthState() => _singleton;
  AuthState._internal();
  User? _user;

  Future<bool> isUserCreated() async {
    var userToken = await _AuthCreator.getUserToken();

    return userToken != null;
  }

  bool isLoggedIn() {
    return _user != null;
  }

  Future<void> createUser(String pin) async {
    var userToken = _AuthCrypto.encryptPin(pin);

    await _AuthCreator.createUserToken(userToken);

    _user = User(userToken);
  }

  Future<void> login(String pin) async {
    var userToken = await _AuthCreator.getUserToken();
    var encryptedPin = _AuthCrypto.encryptPin(pin);

    if (userToken == encryptedPin) {
      _user = User(userToken!);
    } else {
      throw InvalidPinException();
    }
  }

  Future<bool> localLogin(Localization localization) async {
    var userSettings = await UserSettings().getUserSettings();

    if (userSettings.isBiometricAuthEnabled) {
      var isAuthenticated = await BiometricHelper.authenticate(
        localization,
      );

      if (isAuthenticated) {
        var userToken = await _AuthCreator.getUserToken();

        _user = User(userToken!);
      }

      return isAuthenticated;
    }

    return false;
  }

  Future<void> logout() async {
    await _AuthCreator.deleteUserToken();
  }

  User? getUser() {
    return _user;
  }
}