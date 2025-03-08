import 'package:flutter/material.dart';
import 'package:hogastos/generated/i18n/app_localizations.dart';
import 'package:hogastos/helpers/localization_helper.dart';

class HogastosIcon {
  final String key;
  final IconData iconData;
  final String Function(AppLocalizations) _getSearchTags;

  const HogastosIcon(this.key, this.iconData, this._getSearchTags);

  String searchTags(BuildContext context)
    => _getSearchTags(LocalizationHelper.localization(context));
}

String _accountBalanceSearchTag(AppLocalizations localization) => localization.iconSearchTagsAccountBalance;
const _accountBalanceIcon = HogastosIcon(
  'accountBalance',
  Icons.account_balance,
  _accountBalanceSearchTag,
);

String _beachSearchTag(AppLocalizations localization) => localization.iconSearchTagsBeach;
const _beachIcon = HogastosIcon(
  'beach',
  Icons.beach_access,
  _beachSearchTag,
);

String _bedSearchTag(AppLocalizations localization) => localization.iconSearchTagsBed;
const _bedIcon = HogastosIcon(
  'bed',
  Icons.king_bed,
  _bedSearchTag,
);

String _bikeSearchTag(AppLocalizations localization) => localization.iconSearchTagsBike;
const _bikeIcon = HogastosIcon(
  'bike',
  Icons.pedal_bike,
  _bikeSearchTag,
);

String _busSearchTag(AppLocalizations localization) => localization.iconSearchTagsBus;
const _busIcon = HogastosIcon(
  'bus',
  Icons.directions_bus,
  _busSearchTag,
);

String _businessSearchTag(AppLocalizations localization) => localization.iconSearchTagsBusiness;
const _businessIcon = HogastosIcon(
  'business',
  Icons.business,
  _businessSearchTag,
);

String _cakeSearchTag(AppLocalizations localization) => localization.iconSearchTagsCake;
const _cakeIcon = HogastosIcon(
  'cake',
  Icons.cake,
  _cakeSearchTag,
);

String _carSearchTag(AppLocalizations localization) => localization.iconSearchTagsCar;
const _carIcon = HogastosIcon(
  'car',
  Icons.directions_car,
  _carSearchTag,
);

String _checkroomSearchTag(AppLocalizations localization) => localization.iconSearchTagsCheckroom;
const _checkroomIcon = HogastosIcon(
  'checkroom',
  Icons.checkroom,
  _checkroomSearchTag,
);

String _childSearchTag(AppLocalizations localization) => localization.iconSearchTagsChild;
const _childIcon = HogastosIcon(
  'child',
  Icons.child_friendly,
  _childSearchTag,
);

String _homeSearchTag(AppLocalizations localization) => localization.iconSearchTagsHome;
const _homeIcon = HogastosIcon(
  'home',
  Icons.home,
  _homeSearchTag,
);

String _gameSearchTag(AppLocalizations localization) => localization.iconSearchTagsGame;
const _gameIcon = HogastosIcon(
  'game',
  Icons.sports_esports,
  _gameSearchTag,
);

String _gasSearchTag(AppLocalizations localization) => localization.iconSearchTagsGas;
const _gasIcon = HogastosIcon(
  'gas',
  Icons.local_gas_station,
  _gasSearchTag,
);

String _gradeSearchTag(AppLocalizations localization) => localization.iconSearchTagsGrade;
const _gradeIcon = HogastosIcon(
  'grade',
  Icons.grade,
  _gradeSearchTag,
);

String _lightbulbSearchTag(AppLocalizations localization) => localization.iconSearchTagsLightbulb;
const _lightbulbIcon = HogastosIcon(
  'lightbulb',
  Icons.lightbulb,
  _lightbulbSearchTag,
);

String _placeholderSearchTag(AppLocalizations localization) => localization.iconSearchTagsPlaceholder;
const _placeholderIcon = HogastosIcon(
  'placeholder',
  Icons.hourglass_empty,
  _placeholderSearchTag,
);

String _planeSearchTag(AppLocalizations localization) => localization.iconSearchTagsPlane;
const _planeIcon = HogastosIcon(
  'plane',
  Icons.airplanemode_active,
  _planeSearchTag,
);

String _recyclingSearchTag(AppLocalizations localization) => localization.iconSearchTagsRecycling;
const _recyclingIcon = HogastosIcon(
  'recycling',
  Icons.recycling,
  _recyclingSearchTag,
);

String _shoppingSearchTag(AppLocalizations localization) => localization.iconSearchTagsShopping;
const _shoppingIcon = HogastosIcon(
  'shopping',
  Icons.shopping_bag,
  _shoppingSearchTag,
);

String _soccerSearchTag(AppLocalizations localization) => localization.iconSearchTagsSoccer;
const _soccerIcon = HogastosIcon(
  'soccer',
  Icons.sports_soccer,
  _soccerSearchTag,
);

String _solidaritySearchTag(AppLocalizations localization) => localization.iconSearchTagsSolidarity;
const _solidarityIcon = HogastosIcon(
  'solidarity',
  Icons.local_hospital,
  _solidaritySearchTag,
);

String _supermarketSearchTag(AppLocalizations localization) => localization.iconSearchTagsSupermarket;
const _supermarketIcon = HogastosIcon(
  'supermarket',
  Icons.local_grocery_store,
  _supermarketSearchTag,
);

String _trainSearchTag(AppLocalizations localization) => localization.iconSearchTagsTrain;
const _trainIcon = HogastosIcon(
  'train',
  Icons.train,
  _trainSearchTag,
);

String _womanSearchTag(AppLocalizations localization) => localization.iconSearchTagsWoman;
const _womanIcon = HogastosIcon(
  'woman',
  Icons.woman,
  _womanSearchTag,
);

class HogastosIcons {
  static get accountBalance => _accountBalanceIcon;
  static get beach => _beachIcon;
  static get bed => _bedIcon;
  static get bike => _bikeIcon;
  static get bus => _busIcon;
  static get business => _businessIcon;
  static get cake => _cakeIcon;
  static get car => _carIcon;
  static get checkroom => _checkroomIcon;
  static get child => _childIcon;
  static get home => _homeIcon;
  static get game => _gameIcon;
  static get gas => _gasIcon;
  static get grade => _gradeIcon;
  static get lightbulb => _lightbulbIcon;
  static get placeholder => _placeholderIcon;
  static get plane => _planeIcon;
  static get recycling => _recyclingIcon;
  static get shopping => _shoppingIcon;
  static get soccer => _soccerIcon;
  static get solidarity => _solidarityIcon;
  static get supermarket => _supermarketIcon;
  static get train => _trainIcon;
  static get woman => _womanIcon;

  static List<HogastosIcon> get values => [
    accountBalance,
    beach,
    bed,
    bike,
    bus,
    business,
    cake,
    car,
    checkroom,
    child,
    home,
    game,
    gas,
    grade,
    lightbulb,
    placeholder,
    plane,
    recycling,
    shopping,
    soccer,
    solidarity,
    supermarket,
    train,
    woman,
  ];
}