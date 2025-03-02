import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/helpers/localization_helper.dart';
import 'package:money2/money2.dart';

typedef FormValidator = String? Function(String? newValue);
typedef FormValidatorBuilder = FormValidator Function(BuildContext context);

typedef ValueValidator = bool Function(String? newValue);

var _euroCurrency = Currency.create(
  'EUR',
  2,
  symbol: '€',
  groupSeparator: '.',
  decimalSeparator: ',',
  pattern: '#,##0.00 S'
); // TODO change this to make it multilanguage-currency

class FormValidatorHelper {
  final AppLocalizations _localizations;
  final List<FormValidator> _validators = [];

  FormValidatorHelper(this._localizations);

  static FormValidatorHelper of(BuildContext context)
    => FormValidatorHelper(LocalizationHelper.localization(context));

  FormValidatorHelper isRequired() {
    String? isRequiredValidator(String? newValue) {
      if(newValue?.isEmpty ?? true) {
        return _localizations.validationsIsRequired;
      }

      return null;
    }

    _validators.add(isRequiredValidator);

    return this;
  }

  FormValidatorHelper minLength(int minLength) {
    String? minLengthValidator(String? newValue) {
      var value = newValue ?? '';

      if(value.length < minLength) {
        return _localizations.validationsMinLength(minLength);
      }

      return null;
    }

    _validators.add(minLengthValidator);

    return this;
  }

  FormValidatorHelper maxLength(int maxLength) {
    String? maxLengthValidator(String? newValue) {
      var value = newValue ?? '';

      if(value.length > maxLength) {
        return _localizations.validationsMaxLength(maxLength);
      }

      return null;
    }

    _validators.add(maxLengthValidator);

    return this;
  }

  FormValidatorHelper isFormatRequired(ValueValidator isFormatValid) {
    String? formatValidator(String? newValue) {
      if(!isFormatValid(newValue)) {
        return _localizations.validationsWrongFormat;
      }

      return null;
    }

    _validators.add(formatValidator);

    return this;
  }

  static bool isAmountValueValid(String? newValue) {
    var value = newValue ?? '';
    var money = Money.tryParse(value, isoCode: _euroCurrency.isoCode);

    return value.isNotEmpty && money != null;
  }

  FormValidatorHelper isValidValue(ValueValidator isValidValue) {
    String? valueValidator(String? newValue) {
      if(!isValidValue(newValue)) {
        return _localizations.validationsWrongFormat;
      }

      return null;
    }

    _validators.add(valueValidator);

    return this;
  }

  String? validator(String? newValue) {
    for(var validator in _validators) {
      var result = validator(newValue);

      if(result != null) {
        return result;
      }
    }

    return null;
  }
}