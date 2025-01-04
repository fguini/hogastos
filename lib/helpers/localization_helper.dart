import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationHelper {
  static AppLocalizations localization(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  static String getCurrencySymbol(BuildContext context) {
    var amount = LocalizationHelper.localization(context).amountCurrency(0);

    return amount.substring(4);
  }
}