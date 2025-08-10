import 'package:hogastos/models/dates/month_and_year.dart';
import 'package:hogastos/models/utils/serializable.dart';

class FiltersOnInHome implements JsonConvert<FiltersOnInHome> {
  final bool incomesOn;
  final bool expensesOn;
  final bool notComputableOn;

  FiltersOnInHome(
    this.incomesOn,
    this.expensesOn,
    this.notComputableOn,
  );

  factory FiltersOnInHome.fromJson(Map<String, dynamic> json) {
    return FiltersOnInHome(
      json['incomesOn'],
      json['expensesOn'],
      json['notComputableOn'],
    );
  }

  factory FiltersOnInHome.defaultValue() {
    return FiltersOnInHome(true, true, true);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'incomesOn': incomesOn,
      'expensesOn': expensesOn,
      'notComputableOn': notComputableOn,
    };
  }
}

class Settings {
  bool isBiometricAuthEnabled;
  bool isGroupedListInHome;
  FiltersOnInHome filtersOnInHome;
  MonthAndYear monthAndYearInHome;

  Settings({
    required this.isBiometricAuthEnabled,
    required this.isGroupedListInHome,
    required this.filtersOnInHome,
    required this.monthAndYearInHome,
  });
}