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

String _booksSearchTag(AppLocalizations localization) => localization.iconSearchTagsBooks;
const _booksIcon = HogastosIcon(
  'books',
  Icons.auto_stories,
  _booksSearchTag,
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

String _fitnessCenterSearchTag(AppLocalizations localization) => localization.iconSearchTagsFitnessCenter;
const _fitnessCenterIcon = HogastosIcon(
  'fitness_center',
  Icons.fitness_center,
  _fitnessCenterSearchTag,
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

String _paidSearchTag(AppLocalizations localization) => localization.iconSearchTagsPaid;
const _paidIcon = HogastosIcon(
  'paid',
  Icons.paid,
  _paidSearchTag,
);

String _physicalTherapySearchTag(AppLocalizations localization) => localization.iconSearchTagsPhysicalTherapy;
const _physicalTherapyIcon = HogastosIcon(
  'physicalTherapy',
  Icons.personal_injury,
  _physicalTherapySearchTag,
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

String _questionMarkSearchTag(AppLocalizations localization) => localization.iconSearchTagsQuestionMark;
const _questionMarkIcon = HogastosIcon(
  'questionMark',
  Icons.question_mark,
  _questionMarkSearchTag,
);

String _realEstateAgentSearchTag(AppLocalizations localization) => localization.iconSearchTagsRealEstateAgent;
const _realEstateAgentIcon = HogastosIcon(
  'realEstateAgent',
  Icons.real_estate_agent_outlined,
  _realEstateAgentSearchTag,
);

String _recyclingSearchTag(AppLocalizations localization) => localization.iconSearchTagsRecycling;
const _recyclingIcon = HogastosIcon(
  'recycling',
  Icons.recycling,
  _recyclingSearchTag,
);

String _restaurantSearchTag(AppLocalizations localization) => localization.iconSearchTagsRestaurant;
const _restaurantIcon = HogastosIcon(
  'restaurant',
  Icons.restaurant,
  _restaurantSearchTag,
);

String _savingsSearchTag(AppLocalizations localization) => localization.iconSearchTagsSavings;
const _savingsIcon = HogastosIcon(
  'savings',
  Icons.savings,
  _savingsSearchTag,
);

String _sellSearchTag(AppLocalizations localization) => localization.iconSearchTagsSell;
const _sellIcon = HogastosIcon(
  'sell',
  Icons.sell,
  _sellSearchTag,
);

String _shoppingSearchTag(AppLocalizations localization) => localization.iconSearchTagsShopping;
const _shoppingIcon = HogastosIcon(
  'shopping',
  Icons.shopping_bag,
  _shoppingSearchTag,
);

String _smartphoneSearchTag(AppLocalizations localization) => localization.iconSearchTagsSmartphone;
const _smartphoneIcon = HogastosIcon(
  'smartphone',
  Icons.smartphone,
  _smartphoneSearchTag,
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

String _subscriptionsSearchTag(AppLocalizations localization) => localization.iconSearchTagsSubscriptions;
const _subscriptionsIcon = HogastosIcon(
  'subscriptions',
  Icons.subscriptions,
  _subscriptionsSearchTag,
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

String _volunteerSearchTag(AppLocalizations localization) => localization.iconSearchTagsVolunteer;
const _volunteerIcon = HogastosIcon(
  'volunteer',
  Icons.volunteer_activism,
  _volunteerSearchTag,
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
  static get book => _booksIcon;
  static get bus => _busIcon;
  static get business => _businessIcon;
  static get cake => _cakeIcon;
  static get car => _carIcon;
  static get checkroom => _checkroomIcon;
  static get child => _childIcon;
  static get home => _homeIcon;
  static get fitnessCenter => _fitnessCenterIcon;
  static get game => _gameIcon;
  static get gas => _gasIcon;
  static get grade => _gradeIcon;
  static get lightbulb => _lightbulbIcon;
  static get paid => _paidIcon;
  static get physicalTherapy => _physicalTherapyIcon;
  static get placeholder => _placeholderIcon;
  static get plane => _planeIcon;
  static get questionMark => _questionMarkIcon;
  static get realEstateAgent => _realEstateAgentIcon;
  static get recycling => _recyclingIcon;
  static get restaurant => _restaurantIcon;
  static get sell => _sellIcon;
  static get savings => _savingsIcon;
  static get shopping => _shoppingIcon;
  static get smartphone => _smartphoneIcon;
  static get soccer => _soccerIcon;
  static get solidarity => _solidarityIcon;
  static get subscriptions => _subscriptionsIcon;
  static get supermarket => _supermarketIcon;
  static get train => _trainIcon;
  static get volunteer => _volunteerIcon;
  static get woman => _womanIcon;

  static List<HogastosIcon> get values => [
    accountBalance,
    beach,
    bed,
    bike,
    book,
    bus,
    business,
    cake,
    car,
    checkroom,
    child,
    home,
    fitnessCenter,
    game,
    gas,
    grade,
    lightbulb,
    paid,
    physicalTherapy,
    placeholder,
    plane,
    questionMark,
    realEstateAgent,
    recycling,
    restaurant,
    savings,
    sell,
    shopping,
    smartphone,
    soccer,
    solidarity,
    subscriptions,
    supermarket,
    train,
    volunteer,
    woman,
  ];
}