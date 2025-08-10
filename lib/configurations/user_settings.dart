import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hogastos/models/dates/month_and_year.dart';
import 'package:hogastos/models/settings.dart';
import 'package:hogastos/models/utils/serializable.dart';

AndroidOptions _getAndroidOptions() => const AndroidOptions(
  encryptedSharedPreferences: true,
);


const _biometricAuthKey = 'biometric-auth';
const _isGroupedListInHome = 'is-grouped-list-in-home';
const _filtersOnInHome = 'filters-on-in-home';
const _monthAndYearInHome = 'month-and-year-in-home';

class _SettingsCreator {
  static final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());

  static Future<bool> _getBooleanValue(String key) async {
    var value = await storage.read(key: key);

    return value == null
      ? false
      : bool.parse(value);
  }

  static Future<T?> _getObjectValue<T extends JsonConvert>(
    String key,
    T Function(Map<String, dynamic> data) factory,
  ) async {
    var stringJson = await storage.read(key: key);

    if(stringJson == null) {
      return null;
    }

    return deserialize<T>(stringJson, factory);
  }

  static Future<bool> getBiometricAuth() =>
    _getBooleanValue(_biometricAuthKey);
  static Future<bool> getIsGroupedListInHome() =>
    _getBooleanValue(_isGroupedListInHome);
  static Future<FiltersOnInHome> getFiltersOnInHome() async =>
    await _getObjectValue<FiltersOnInHome>(
      _filtersOnInHome,
      FiltersOnInHome.fromJson
    ) ?? FiltersOnInHome.defaultValue();
  static Future<MonthAndYear> getMonthAndYearInHome() async =>
    await _getObjectValue<MonthAndYear>(
      _monthAndYearInHome,
      MonthAndYear.fromJson
    ) ?? MonthAndYear.now();

  static Future<void> saveBiometricAuth(bool isEnabled) async =>
    await storage.write(key: _biometricAuthKey, value: isEnabled.toString());
  static Future<void> saveIsGroupedListInHome(bool isGrouped) async =>
    await storage.write(key: _isGroupedListInHome, value: isGrouped.toString());
  static Future<void> saveFiltersOnInHome(FiltersOnInHome filtersOn) async =>
    await storage.write(key: _filtersOnInHome, value: serialize(filtersOn));
  static Future<void> saveMonthAndYearInHome(MonthAndYear monthAndYear) async =>
    await storage.write(key: _monthAndYearInHome, value: serialize(monthAndYear));
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
      filtersOnInHome: await _SettingsCreator.getFiltersOnInHome(),
      monthAndYearInHome: await _SettingsCreator.getMonthAndYearInHome(),
    );

    return settings!;
  }

  Future<void> saveBiometricAuth(bool isEnabled) async {
    await _SettingsCreator.saveBiometricAuth(isEnabled);

    settings?.isBiometricAuthEnabled = isEnabled;
  }

  Future<void> saveIsGroupedListInHome(bool isGrouped) async {
    await _SettingsCreator.saveIsGroupedListInHome(isGrouped);

    settings?.isGroupedListInHome = isGrouped;
  }

  Future<void> saveFiltersOnInHome(
    bool expensesOn,
    bool incomesOn,
    bool notComputableOn
  ) async {
    var newFiltersOnInHome = FiltersOnInHome(
      expensesOn,
      incomesOn,
      notComputableOn,
    );
    await _SettingsCreator.saveFiltersOnInHome(newFiltersOnInHome);

    settings?.filtersOnInHome = newFiltersOnInHome;
  }

  Future<void> saveMonthAndYearInHome(MonthAndYear monthAndYear) async {
    await _SettingsCreator.saveMonthAndYearInHome(monthAndYear);

    settings?.monthAndYearInHome = monthAndYear;
  }
}