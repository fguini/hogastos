import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('es')];

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Hogastos'**
  String get appTitle;

  /// No description provided for @actionsBack.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get actionsBack;

  /// No description provided for @actionsClose.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get actionsClose;

  /// No description provided for @actionsCreate.
  ///
  /// In es, this message translates to:
  /// **'Crear'**
  String get actionsCreate;

  /// No description provided for @actionsCreateNewCategory.
  ///
  /// In es, this message translates to:
  /// **'Crear nueva categoría'**
  String get actionsCreateNewCategory;

  /// No description provided for @actionsCreateNewMovement.
  ///
  /// In es, this message translates to:
  /// **'Crear nuevo movimiento'**
  String get actionsCreateNewMovement;

  /// No description provided for @actionsDelete.
  ///
  /// In es, this message translates to:
  /// **'Eliminar'**
  String get actionsDelete;

  /// No description provided for @actionsExport.
  ///
  /// In es, this message translates to:
  /// **'Exportar'**
  String get actionsExport;

  /// No description provided for @actionsExportToExcel.
  ///
  /// In es, this message translates to:
  /// **'Exportar movimientos a un excel'**
  String get actionsExportToExcel;

  /// No description provided for @actionsGo.
  ///
  /// In es, this message translates to:
  /// **'Ir'**
  String get actionsGo;

  /// No description provided for @actionsImport.
  ///
  /// In es, this message translates to:
  /// **'Importar'**
  String get actionsImport;

  /// No description provided for @actionsImportFromExcel.
  ///
  /// In es, this message translates to:
  /// **'Importar movimientos desde un excel'**
  String get actionsImportFromExcel;

  /// No description provided for @actionsLogin.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get actionsLogin;

  /// No description provided for @actionsLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get actionsLogout;

  /// No description provided for @actionsRead.
  ///
  /// In es, this message translates to:
  /// **'Ver'**
  String get actionsRead;

  /// No description provided for @actionsReadCategories.
  ///
  /// In es, this message translates to:
  /// **'Ver listado de categorías'**
  String get actionsReadCategories;

  /// No description provided for @actionsReadYearlyReport.
  ///
  /// In es, this message translates to:
  /// **'Ver reporte de balance anual'**
  String get actionsReadYearlyReport;

  /// No description provided for @actionsSave.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get actionsSave;

  /// No description provided for @actionsSearch.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get actionsSearch;

  /// No description provided for @alphabet.
  ///
  /// In es, this message translates to:
  /// **'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ'**
  String get alphabet;

  /// Localization for amount plus currency
  ///
  /// In es, this message translates to:
  /// **'{amount}'**
  String amountCurrency(double amount);

  /// No description provided for @biometricAuthBiometricHint.
  ///
  /// In es, this message translates to:
  /// **'Verifica que eres tu'**
  String get biometricAuthBiometricHint;

  /// No description provided for @biometricAuthBiometricNotRecognized.
  ///
  /// In es, this message translates to:
  /// **'No reconocido'**
  String get biometricAuthBiometricNotRecognized;

  /// No description provided for @biometricAuthBiometricRequiredTitle.
  ///
  /// In es, this message translates to:
  /// **'Es necesario realizar autenticación biometrica'**
  String get biometricAuthBiometricRequiredTitle;

  /// No description provided for @biometricAuthBiometricSuccess.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido/a!'**
  String get biometricAuthBiometricSuccess;

  /// No description provided for @biometricAuthCancelButton.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get biometricAuthCancelButton;

  /// No description provided for @biometricAuthDeviceCredentialsRequiredTitle.
  ///
  /// In es, this message translates to:
  /// **'Permisos de dispositivo'**
  String get biometricAuthDeviceCredentialsRequiredTitle;

  /// No description provided for @biometricAuthDeviceCredentialsSetupDescription.
  ///
  /// In es, this message translates to:
  /// **'Es necesario configurar el dispositivo para habilitar la autenticación biometrica. Ve a las opciones para hacerlo.'**
  String get biometricAuthDeviceCredentialsSetupDescription;

  /// No description provided for @biometricAuthGoToSettingsButton.
  ///
  /// In es, this message translates to:
  /// **'Ir a la configuración'**
  String get biometricAuthGoToSettingsButton;

  /// No description provided for @biometricAuthGoToSettingsDescription.
  ///
  /// In es, this message translates to:
  /// **'Ir \'Configuración > Seguridad\' para activar la configuración biométrica.'**
  String get biometricAuthGoToSettingsDescription;

  /// No description provided for @biometricAuthReason.
  ///
  /// In es, this message translates to:
  /// **'Autentica para acceder a la aplicación'**
  String get biometricAuthReason;

  /// No description provided for @biometricAuthSignInTitle.
  ///
  /// In es, this message translates to:
  /// **'Es necesario iniciar sesión'**
  String get biometricAuthSignInTitle;

  /// No description provided for @categories.
  ///
  /// In es, this message translates to:
  /// **'Categorías'**
  String get categories;

  /// No description provided for @category.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get category;

  /// No description provided for @categoryDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'Antes de eliminar la categoría'**
  String get categoryDeleteTitle;

  /// No description provided for @categoryDeleteDescription.
  ///
  /// In es, this message translates to:
  /// **'Esta categoría ya tiene movimientos. Antes de eliminarla, quieres mover todos sus movimientos a otra categoría?'**
  String get categoryDeleteDescription;

  /// No description provided for @categorySelectColor.
  ///
  /// In es, this message translates to:
  /// **'Selecciona color'**
  String get categorySelectColor;

  /// No description provided for @categorySelectIcon.
  ///
  /// In es, this message translates to:
  /// **'Selecciona icono'**
  String get categorySelectIcon;

  /// No description provided for @categorySelectIconNotSelected.
  ///
  /// In es, this message translates to:
  /// **'Ningún icono seleccionado'**
  String get categorySelectIconNotSelected;

  /// No description provided for @categorySelectIconNoResults.
  ///
  /// In es, this message translates to:
  /// **'Sin resultados para'**
  String get categorySelectIconNoResults;

  /// No description provided for @computable.
  ///
  /// In es, this message translates to:
  /// **'Computable'**
  String get computable;

  /// No description provided for @excelHeaderCategory.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get excelHeaderCategory;

  /// No description provided for @excelHeaderDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha'**
  String get excelHeaderDate;

  /// No description provided for @excelHeaderDescription.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get excelHeaderDescription;

  /// No description provided for @excelHeaderAmount.
  ///
  /// In es, this message translates to:
  /// **'Importe'**
  String get excelHeaderAmount;

  /// No description provided for @expense.
  ///
  /// In es, this message translates to:
  /// **'Gasto'**
  String get expense;

  /// No description provided for @expenses.
  ///
  /// In es, this message translates to:
  /// **'Gastos'**
  String get expenses;

  /// No description provided for @exportToExcel.
  ///
  /// In es, this message translates to:
  /// **'Exportar a excel'**
  String get exportToExcel;

  /// No description provided for @exportToExcelAllMonths.
  ///
  /// In es, this message translates to:
  /// **'Exportar todos los meses'**
  String get exportToExcelAllMonths;

  /// No description provided for @exportToExcelExport.
  ///
  /// In es, this message translates to:
  /// **'Exportar'**
  String get exportToExcelExport;

  /// No description provided for @exportToExcelSuccess.
  ///
  /// In es, this message translates to:
  /// **'Se han exportado los movimientos al archivo seleccionado!'**
  String get exportToExcelSuccess;

  /// No description provided for @iconSearchTagsAccountBalance.
  ///
  /// In es, this message translates to:
  /// **'banco cuenta corriente balance nomina'**
  String get iconSearchTagsAccountBalance;

  /// No description provided for @iconSearchTagsBeach.
  ///
  /// In es, this message translates to:
  /// **'playa vacaciones costa sombrilla'**
  String get iconSearchTagsBeach;

  /// No description provided for @iconSearchTagsBed.
  ///
  /// In es, this message translates to:
  /// **'cama alojamiento vacaciones habitacion'**
  String get iconSearchTagsBed;

  /// No description provided for @iconSearchTagsBike.
  ///
  /// In es, this message translates to:
  /// **'bici bicicleta moto motocicleta transporte transladar viaje deporte actividad'**
  String get iconSearchTagsBike;

  /// No description provided for @iconSearchTagsBooks.
  ///
  /// In es, this message translates to:
  /// **'libro libreria biblioteca papel'**
  String get iconSearchTagsBooks;

  /// No description provided for @iconSearchTagsBus.
  ///
  /// In es, this message translates to:
  /// **'autobus bus colectivo publico público transporte direccion'**
  String get iconSearchTagsBus;

  /// No description provided for @iconSearchTagsBusiness.
  ///
  /// In es, this message translates to:
  /// **'trabajo oficina edificio'**
  String get iconSearchTagsBusiness;

  /// No description provided for @iconSearchTagsCake.
  ///
  /// In es, this message translates to:
  /// **'tarta torta cumpleaños cumple aniversario año'**
  String get iconSearchTagsCake;

  /// No description provided for @iconSearchTagsCar.
  ///
  /// In es, this message translates to:
  /// **'carro coche auto automovil transporte direccion'**
  String get iconSearchTagsCar;

  /// No description provided for @iconSearchTagsCheckroom.
  ///
  /// In es, this message translates to:
  /// **'percha ropa orden armario'**
  String get iconSearchTagsCheckroom;

  /// No description provided for @iconSearchTagsChild.
  ///
  /// In es, this message translates to:
  /// **'niño bebe niña beba carrito cochecito'**
  String get iconSearchTagsChild;

  /// No description provided for @iconSearchTagsHome.
  ///
  /// In es, this message translates to:
  /// **'casa hogar domestico'**
  String get iconSearchTagsHome;

  /// No description provided for @iconSearchTagsFitnessCenter.
  ///
  /// In es, this message translates to:
  /// **'gimnasio deporte fitness'**
  String get iconSearchTagsFitnessCenter;

  /// No description provided for @iconSearchTagsGame.
  ///
  /// In es, this message translates to:
  /// **'ocio juegos videojuegos videos'**
  String get iconSearchTagsGame;

  /// No description provided for @iconSearchTagsGas.
  ///
  /// In es, this message translates to:
  /// **'gas gasolina nafta estacion de servicio gasolinera coche transporte'**
  String get iconSearchTagsGas;

  /// No description provided for @iconSearchTagsGrade.
  ///
  /// In es, this message translates to:
  /// **'estrella nivel grado favorito especial'**
  String get iconSearchTagsGrade;

  /// No description provided for @iconSearchTagsLightbulb.
  ///
  /// In es, this message translates to:
  /// **'bombilla bombita luz servicios'**
  String get iconSearchTagsLightbulb;

  /// No description provided for @iconSearchTagsPaid.
  ///
  /// In es, this message translates to:
  /// **'dinero ahorro plata moneda balance'**
  String get iconSearchTagsPaid;

  /// No description provided for @iconSearchTagsPhysicalTherapy.
  ///
  /// In es, this message translates to:
  /// **'fisio kinesiologia fisioterapia lesion fisica'**
  String get iconSearchTagsPhysicalTherapy;

  /// No description provided for @iconSearchTagsPlane.
  ///
  /// In es, this message translates to:
  /// **'avion avión vuelo volar viaje vacaciones'**
  String get iconSearchTagsPlane;

  /// No description provided for @iconSearchTagsPlaceholder.
  ///
  /// In es, this message translates to:
  /// **'hora horario vacío tiempo espacio hueco'**
  String get iconSearchTagsPlaceholder;

  /// No description provided for @iconSearchTagsQuestionMark.
  ///
  /// In es, this message translates to:
  /// **'pregunta otros duda consulta'**
  String get iconSearchTagsQuestionMark;

  /// No description provided for @iconSearchTagsRecycling.
  ///
  /// In es, this message translates to:
  /// **'reciclar reciclado renovable renovar otros'**
  String get iconSearchTagsRecycling;

  /// No description provided for @iconSearchTagsRestaurant.
  ///
  /// In es, this message translates to:
  /// **'restaurante salir salida comer cena'**
  String get iconSearchTagsRestaurant;

  /// No description provided for @iconSearchTagsRealEstateAgent.
  ///
  /// In es, this message translates to:
  /// **'alquiler de hogar casa prestamo renting'**
  String get iconSearchTagsRealEstateAgent;

  /// No description provided for @iconSearchTagsSavings.
  ///
  /// In es, this message translates to:
  /// **'ahorros dinero guardado'**
  String get iconSearchTagsSavings;

  /// No description provided for @iconSearchTagsSell.
  ///
  /// In es, this message translates to:
  /// **'venta etiqueta marca compra'**
  String get iconSearchTagsSell;

  /// No description provided for @iconSearchTagsShopping.
  ///
  /// In es, this message translates to:
  /// **'compras ropa accesorios centro comercial mall shopping'**
  String get iconSearchTagsShopping;

  /// No description provided for @iconSearchTagsSmartphone.
  ///
  /// In es, this message translates to:
  /// **'movil celular telefono servicio'**
  String get iconSearchTagsSmartphone;

  /// No description provided for @iconSearchTagsSoccer.
  ///
  /// In es, this message translates to:
  /// **'futbol football furbo deporte fulbo balon pelota'**
  String get iconSearchTagsSoccer;

  /// No description provided for @iconSearchTagsSolidarity.
  ///
  /// In es, this message translates to:
  /// **'solidaridad cruz voluntario voluntariado solidario'**
  String get iconSearchTagsSolidarity;

  /// No description provided for @iconSearchTagsSubscriptions.
  ///
  /// In es, this message translates to:
  /// **'subscripciones internet mensual periodica'**
  String get iconSearchTagsSubscriptions;

  /// No description provided for @iconSearchTagsSupermarket.
  ///
  /// In es, this message translates to:
  /// **'super supermercado mercado compras carro carrito compras'**
  String get iconSearchTagsSupermarket;

  /// No description provided for @iconSearchTagsTrain.
  ///
  /// In es, this message translates to:
  /// **'transporte tren ferrocarril'**
  String get iconSearchTagsTrain;

  /// No description provided for @iconSearchTagsVolunteer.
  ///
  /// In es, this message translates to:
  /// **'voluntariado solidario voluntario ayuda'**
  String get iconSearchTagsVolunteer;

  /// No description provided for @iconSearchTagsWoman.
  ///
  /// In es, this message translates to:
  /// **'mujer chica niña femenina'**
  String get iconSearchTagsWoman;

  /// No description provided for @importFromExcel.
  ///
  /// In es, this message translates to:
  /// **'Importar desde excel'**
  String get importFromExcel;

  /// Title of column select dialog
  ///
  /// In es, this message translates to:
  /// **'Columna {columnLetter}'**
  String importFromExcelColumnTitle(String columnLetter);

  /// No description provided for @importFromExcelColumnAssignment.
  ///
  /// In es, this message translates to:
  /// **'Asignar columna a'**
  String get importFromExcelColumnAssignment;

  /// No description provided for @importFromExcelColumnNotAssigned.
  ///
  /// In es, this message translates to:
  /// **'Sin asignar'**
  String get importFromExcelColumnNotAssigned;

  /// No description provided for @importFromExcelColumnApplyToAll.
  ///
  /// In es, this message translates to:
  /// **'Aplicar a todas'**
  String get importFromExcelColumnApplyToAll;

  /// No description provided for @importFromExcelImport.
  ///
  /// In es, this message translates to:
  /// **'Importar'**
  String get importFromExcelImport;

  /// No description provided for @importFromExcelPickFile.
  ///
  /// In es, this message translates to:
  /// **'Seleccionar archivo'**
  String get importFromExcelPickFile;

  /// No description provided for @importFromExcelHasHeaders.
  ///
  /// In es, this message translates to:
  /// **'Tiene cabecera'**
  String get importFromExcelHasHeaders;

  /// No description provided for @importFromExcelPreview.
  ///
  /// In es, this message translates to:
  /// **'Importar (Vista previa)'**
  String get importFromExcelPreview;

  /// No description provided for @importFromExcelPreviewCategories.
  ///
  /// In es, this message translates to:
  /// **'Categorías a ser creados'**
  String get importFromExcelPreviewCategories;

  /// No description provided for @importFromExcelPreviewCategoriesEmpty.
  ///
  /// In es, this message translates to:
  /// **'No se creará ninguna categoría'**
  String get importFromExcelPreviewCategoriesEmpty;

  /// No description provided for @importFromExcelPreviewMovements.
  ///
  /// In es, this message translates to:
  /// **'Movimientos a ser creados'**
  String get importFromExcelPreviewMovements;

  /// No description provided for @importFromExcelSelectFile.
  ///
  /// In es, this message translates to:
  /// **'Selecciona un archivo para comenzar a importar los movimientos'**
  String get importFromExcelSelectFile;

  /// No description provided for @listGroupByCategory.
  ///
  /// In es, this message translates to:
  /// **'Agrupar por categoría'**
  String get listGroupByCategory;

  /// No description provided for @listUngroup.
  ///
  /// In es, this message translates to:
  /// **'Desagrupar lista'**
  String get listUngroup;

  /// No description provided for @income.
  ///
  /// In es, this message translates to:
  /// **'Ingreso'**
  String get income;

  /// No description provided for @incomes.
  ///
  /// In es, this message translates to:
  /// **'Ingresos'**
  String get incomes;

  /// Short month and year text
  ///
  /// In es, this message translates to:
  /// **'{monthDate} {year}'**
  String monthAndYear(DateTime monthDate, int year);

  /// No description provided for @movementAmount.
  ///
  /// In es, this message translates to:
  /// **'Importe'**
  String get movementAmount;

  /// No description provided for @movementDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha del movimiento'**
  String get movementDate;

  /// No description provided for @movementText.
  ///
  /// In es, this message translates to:
  /// **'Concepto'**
  String get movementText;

  /// No description provided for @movements.
  ///
  /// In es, this message translates to:
  /// **'Movimientos'**
  String get movements;

  /// Amount of movements in a category
  ///
  /// In es, this message translates to:
  /// **'{count} movimientos'**
  String movementsCount(int count);

  /// No description provided for @newCategory.
  ///
  /// In es, this message translates to:
  /// **'Nueva categoría'**
  String get newCategory;

  /// No description provided for @newMovement.
  ///
  /// In es, this message translates to:
  /// **'Nuevo movimiento'**
  String get newMovement;

  /// No description provided for @noCategoriesDialogTitle.
  ///
  /// In es, this message translates to:
  /// **'No hay ninguna categoría creada'**
  String get noCategoriesDialogTitle;

  /// No description provided for @noCategoriesDialogDescription.
  ///
  /// In es, this message translates to:
  /// **'Antes de crear un nuevo movimiento es necesario crear una categoría, dale al botón para ir a la pantalla de creación de categorías.'**
  String get noCategoriesDialogDescription;

  /// No description provided for @notComputable.
  ///
  /// In es, this message translates to:
  /// **'No computable'**
  String get notComputable;

  /// No description provided for @notComputableShort.
  ///
  /// In es, this message translates to:
  /// **'NC'**
  String get notComputableShort;

  /// No description provided for @pageCreateUserTitle.
  ///
  /// In es, this message translates to:
  /// **'Crea un pin para acceder'**
  String get pageCreateUserTitle;

  /// No description provided for @reportsYearTitle.
  ///
  /// In es, this message translates to:
  /// **'Reporte de balance anual'**
  String get reportsYearTitle;

  /// No description provided for @totals.
  ///
  /// In es, this message translates to:
  /// **'Totales'**
  String get totals;

  /// No description provided for @validationsIsRequired.
  ///
  /// In es, this message translates to:
  /// **'Es obligatorio'**
  String get validationsIsRequired;

  /// Max length validation
  ///
  /// In es, this message translates to:
  /// **'El tamaño máximo es {length}'**
  String validationsMaxLength(int length);

  /// Min length validation
  ///
  /// In es, this message translates to:
  /// **'El tamaño minimo es {length}'**
  String validationsMinLength(int length);

  /// No description provided for @validationsNotInRange.
  ///
  /// In es, this message translates to:
  /// **'El valor no está dentro de los parametros esperados'**
  String get validationsNotInRange;

  /// No description provided for @validationsWrongFormat.
  ///
  /// In es, this message translates to:
  /// **'El formato es incorrecto'**
  String get validationsWrongFormat;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
