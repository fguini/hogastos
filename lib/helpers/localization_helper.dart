import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';

typedef Localization = AppLocalizations;

class LocalizationHelper {
  static Localization localization(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static String getCurrencySymbol(BuildContext context) {
    var amount = LocalizationHelper.localization(context).amountCurrency(0);

    return amount.substring(4);
  }
}