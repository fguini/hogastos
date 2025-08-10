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
  static HogastosIcon get accountBalance => _accountBalanceIcon;
  static HogastosIcon get beach => _beachIcon;
  static HogastosIcon get bed => _bedIcon;
  static HogastosIcon get bike => _bikeIcon;
  static HogastosIcon get book => _booksIcon;
  static HogastosIcon get bus => _busIcon;
  static HogastosIcon get business => _businessIcon;
  static HogastosIcon get cake => _cakeIcon;
  static HogastosIcon get car => _carIcon;
  static HogastosIcon get checkroom => _checkroomIcon;
  static HogastosIcon get child => _childIcon;
  static HogastosIcon get home => _homeIcon;
  static HogastosIcon get fitnessCenter => _fitnessCenterIcon;
  static HogastosIcon get game => _gameIcon;
  static HogastosIcon get gas => _gasIcon;
  static HogastosIcon get grade => _gradeIcon;
  static HogastosIcon get lightbulb => _lightbulbIcon;
  static HogastosIcon get paid => _paidIcon;
  static HogastosIcon get physicalTherapy => _physicalTherapyIcon;
  static HogastosIcon get placeholder => _placeholderIcon;
  static HogastosIcon get plane => _planeIcon;
  static HogastosIcon get questionMark => _questionMarkIcon;
  static HogastosIcon get realEstateAgent => _realEstateAgentIcon;
  static HogastosIcon get recycling => _recyclingIcon;
  static HogastosIcon get restaurant => _restaurantIcon;
  static HogastosIcon get sell => _sellIcon;
  static HogastosIcon get savings => _savingsIcon;
  static HogastosIcon get shopping => _shoppingIcon;
  static HogastosIcon get smartphone => _smartphoneIcon;
  static HogastosIcon get soccer => _soccerIcon;
  static HogastosIcon get solidarity => _solidarityIcon;
  static HogastosIcon get subscriptions => _subscriptionsIcon;
  static HogastosIcon get supermarket => _supermarketIcon;
  static HogastosIcon get train => _trainIcon;
  static HogastosIcon get volunteer => _volunteerIcon;
  static HogastosIcon get woman => _womanIcon;

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