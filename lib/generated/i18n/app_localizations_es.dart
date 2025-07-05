// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Hogastos';

  @override
  String get actionsBack => 'Volver';

  @override
  String get actionsClose => 'Cerrar';

  @override
  String get actionsCreate => 'Crear';

  @override
  String get actionsCreateNewCategory => 'Crear nueva categoría';

  @override
  String get actionsCreateNewMovement => 'Crear nuevo movimiento';

  @override
  String get actionsDelete => 'Eliminar';

  @override
  String get actionsExport => 'Exportar';

  @override
  String get actionsExportToExcel => 'Exportar movimientos a un excel';

  @override
  String get actionsGo => 'Ir';

  @override
  String get actionsImport => 'Importar';

  @override
  String get actionsImportFromExcel => 'Importar movimientos desde un excel';

  @override
  String get actionsLogin => 'Iniciar sesión';

  @override
  String get actionsLogout => 'Cerrar sesión';

  @override
  String get actionsRead => 'Ver';

  @override
  String get actionsReadCategories => 'Ver listado de categorías';

  @override
  String get actionsReadYearlyReport => 'Ver reporte de balance anual';

  @override
  String get actionsSave => 'Guardar';

  @override
  String get actionsSearch => 'Buscar';

  @override
  String get alphabet => 'ABCDEFGHIJKLMNÑOPQRSTUVWXYZ';

  @override
  String amountCurrency(double amount) {
    final intl.NumberFormat amountNumberFormat = intl
        .NumberFormat.simpleCurrency(locale: localeName, decimalDigits: 2);
    final String amountString = amountNumberFormat.format(amount);

    return '$amountString';
  }

  @override
  String get biometricAuthBiometricHint => 'Verifica que eres tu';

  @override
  String get biometricAuthBiometricNotRecognized => 'No reconocido';

  @override
  String get biometricAuthBiometricRequiredTitle =>
      'Es necesario realizar autenticación biometrica';

  @override
  String get biometricAuthBiometricSuccess => 'Bienvenido/a!';

  @override
  String get biometricAuthCancelButton => 'Cancelar';

  @override
  String get biometricAuthDeviceCredentialsRequiredTitle =>
      'Permisos de dispositivo';

  @override
  String get biometricAuthDeviceCredentialsSetupDescription =>
      'Es necesario configurar el dispositivo para habilitar la autenticación biometrica. Ve a las opciones para hacerlo.';

  @override
  String get biometricAuthGoToSettingsButton => 'Ir a la configuración';

  @override
  String get biometricAuthGoToSettingsDescription =>
      'Ir \'Configuración > Seguridad\' para activar la configuración biométrica.';

  @override
  String get biometricAuthReason => 'Autentica para acceder a la aplicación';

  @override
  String get biometricAuthSignInTitle => 'Es necesario iniciar sesión';

  @override
  String get categories => 'Categorías';

  @override
  String get category => 'Categoría';

  @override
  String get categoryDeleteTitle => 'Antes de eliminar la categoría';

  @override
  String get categoryDeleteDescription =>
      'Esta categoría ya tiene movimientos. Antes de eliminarla, quieres mover todos sus movimientos a otra categoría?';

  @override
  String get categorySelectColor => 'Selecciona color';

  @override
  String get categorySelectIcon => 'Selecciona icono';

  @override
  String get categorySelectIconNotSelected => 'Ningún icono seleccionado';

  @override
  String get categorySelectIconNoResults => 'Sin resultados para';

  @override
  String get computable => 'Computable';

  @override
  String get excelHeaderCategory => 'Categoría';

  @override
  String get excelHeaderDate => 'Fecha';

  @override
  String get excelHeaderDescription => 'Descripción';

  @override
  String get excelHeaderAmount => 'Importe';

  @override
  String get expense => 'Gasto';

  @override
  String get expenses => 'Gastos';

  @override
  String get exportToExcel => 'Exportar a excel';

  @override
  String get exportToExcelAllMonths => 'Exportar todos los meses';

  @override
  String get exportToExcelExport => 'Exportar';

  @override
  String get exportToExcelSuccess =>
      'Se han exportado los movimientos al archivo seleccionado!';

  @override
  String get iconSearchTagsAccountBalance =>
      'banco cuenta corriente balance nomina';

  @override
  String get iconSearchTagsBeach => 'playa vacaciones costa sombrilla';

  @override
  String get iconSearchTagsBed => 'cama alojamiento vacaciones habitacion';

  @override
  String get iconSearchTagsBike =>
      'bici bicicleta moto motocicleta transporte transladar viaje deporte actividad';

  @override
  String get iconSearchTagsBooks => 'libro libreria biblioteca papel';

  @override
  String get iconSearchTagsBus =>
      'autobus bus colectivo publico público transporte direccion';

  @override
  String get iconSearchTagsBusiness => 'trabajo oficina edificio';

  @override
  String get iconSearchTagsCake =>
      'tarta torta cumpleaños cumple aniversario año';

  @override
  String get iconSearchTagsCar =>
      'carro coche auto automovil transporte direccion';

  @override
  String get iconSearchTagsCheckroom => 'percha ropa orden armario';

  @override
  String get iconSearchTagsChild => 'niño bebe niña beba carrito cochecito';

  @override
  String get iconSearchTagsHome => 'casa hogar domestico';

  @override
  String get iconSearchTagsFitnessCenter => 'gimnasio deporte fitness';

  @override
  String get iconSearchTagsGame => 'ocio juegos videojuegos videos';

  @override
  String get iconSearchTagsGas =>
      'gas gasolina nafta estacion de servicio gasolinera coche transporte';

  @override
  String get iconSearchTagsGrade => 'estrella nivel grado favorito especial';

  @override
  String get iconSearchTagsLightbulb => 'bombilla bombita luz servicios';

  @override
  String get iconSearchTagsPaid => 'dinero ahorro plata moneda balance';

  @override
  String get iconSearchTagsPhysicalTherapy =>
      'fisio kinesiologia fisioterapia lesion fisica';

  @override
  String get iconSearchTagsPlane => 'avion avión vuelo volar viaje vacaciones';

  @override
  String get iconSearchTagsPlaceholder =>
      'hora horario vacío tiempo espacio hueco';

  @override
  String get iconSearchTagsQuestionMark => 'pregunta otros duda consulta';

  @override
  String get iconSearchTagsRecycling =>
      'reciclar reciclado renovable renovar otros';

  @override
  String get iconSearchTagsRestaurant => 'restaurante salir salida comer cena';

  @override
  String get iconSearchTagsRealEstateAgent =>
      'alquiler de hogar casa prestamo renting';

  @override
  String get iconSearchTagsSavings => 'ahorros dinero guardado';

  @override
  String get iconSearchTagsSell => 'venta etiqueta marca compra';

  @override
  String get iconSearchTagsShopping =>
      'compras ropa accesorios centro comercial mall shopping';

  @override
  String get iconSearchTagsSmartphone => 'movil celular telefono servicio';

  @override
  String get iconSearchTagsSoccer =>
      'futbol football furbo deporte fulbo balon pelota';

  @override
  String get iconSearchTagsSolidarity =>
      'solidaridad cruz voluntario voluntariado solidario';

  @override
  String get iconSearchTagsSubscriptions =>
      'subscripciones internet mensual periodica';

  @override
  String get iconSearchTagsSupermarket =>
      'super supermercado mercado compras carro carrito compras';

  @override
  String get iconSearchTagsTrain => 'transporte tren ferrocarril';

  @override
  String get iconSearchTagsVolunteer =>
      'voluntariado solidario voluntario ayuda';

  @override
  String get iconSearchTagsWoman => 'mujer chica niña femenina';

  @override
  String get importFromExcel => 'Importar desde excel';

  @override
  String importFromExcelColumnTitle(String columnLetter) {
    return 'Columna $columnLetter';
  }

  @override
  String get importFromExcelColumnAssignment => 'Asignar columna a';

  @override
  String get importFromExcelColumnNotAssigned => 'Sin asignar';

  @override
  String get importFromExcelColumnApplyToAll => 'Aplicar a todas';

  @override
  String get importFromExcelImport => 'Importar';

  @override
  String get importFromExcelPickFile => 'Seleccionar archivo';

  @override
  String get importFromExcelHasHeaders => 'Tiene cabecera';

  @override
  String get importFromExcelPreview => 'Importar (Vista previa)';

  @override
  String get importFromExcelPreviewCategories => 'Categorías a ser creados';

  @override
  String get importFromExcelPreviewCategoriesEmpty =>
      'No se creará ninguna categoría';

  @override
  String get importFromExcelPreviewMovements => 'Movimientos a ser creados';

  @override
  String get importFromExcelSelectFile =>
      'Selecciona un archivo para comenzar a importar los movimientos';

  @override
  String get listGroupByCategory => 'Agrupar por categoría';

  @override
  String get listUngroup => 'Desagrupar lista';

  @override
  String get income => 'Ingreso';

  @override
  String get incomes => 'Ingresos';

  @override
  String monthAndYear(DateTime monthDate, int year) {
    final intl.DateFormat monthDateDateFormat = intl.DateFormat.MMM(localeName);
    final String monthDateString = monthDateDateFormat.format(monthDate);

    return '$monthDateString $year';
  }

  @override
  String get movementAmount => 'Importe';

  @override
  String get movementDate => 'Fecha del movimiento';

  @override
  String get movementText => 'Concepto';

  @override
  String get movements => 'Movimientos';

  @override
  String movementsCount(int count) {
    return '$count movimientos';
  }

  @override
  String get newCategory => 'Nueva categoría';

  @override
  String get newMovement => 'Nuevo movimiento';

  @override
  String get noCategoriesDialogTitle => 'No hay ninguna categoría creada';

  @override
  String get noCategoriesDialogDescription =>
      'Antes de crear un nuevo movimiento es necesario crear una categoría, dale al botón para ir a la pantalla de creación de categorías.';

  @override
  String get notComputable => 'No computable';

  @override
  String get notComputableShort => 'NC';

  @override
  String get pageCreateUserTitle => 'Crea un pin para acceder';

  @override
  String get totals => 'Totales';

  @override
  String get validationsIsRequired => 'Es obligatorio';

  @override
  String validationsMaxLength(int length) {
    return 'El tamaño máximo es $length';
  }

  @override
  String validationsMinLength(int length) {
    return 'El tamaño minimo es $length';
  }

  @override
  String get validationsNotInRange =>
      'El valor no está dentro de los parametros esperados';

  @override
  String get validationsWrongFormat => 'El formato es incorrecto';
}
