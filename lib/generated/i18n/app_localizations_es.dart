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
  String amountCurrency(double amount) {
    final intl.NumberFormat amountNumberFormat = intl.NumberFormat.simpleCurrency(
      locale: localeName,
      decimalDigits: 2
    );
    final String amountString = amountNumberFormat.format(amount);

    return '$amountString';
  }

  @override
  String get biometricAuthBiometricHint => 'Verifica que eres tu';

  @override
  String get biometricAuthBiometricNotRecognized => 'No reconocido';

  @override
  String get biometricAuthBiometricRequiredTitle => 'Es necesario realizar autenticación biometrica';

  @override
  String get biometricAuthBiometricSuccess => 'Bienvenido/a!';

  @override
  String get biometricAuthCancelButton => 'Cancelar';

  @override
  String get biometricAuthDeviceCredentialsRequiredTitle => 'Permisos de dispositivo';

  @override
  String get biometricAuthDeviceCredentialsSetupDescription => 'Es necesario configurar el dispositivo para habilitar la autenticación biometrica. Ve a las opciones para hacerlo.';

  @override
  String get biometricAuthGoToSettingsButton => 'Ir a la configuración';

  @override
  String get biometricAuthGoToSettingsDescription => 'Ir \'Configuración > Seguridad\' para activar la configuración biométrica.';

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
  String get categoryDeleteDescription => 'Esta categoría ya tiene movimientos. Antes de eliminarla, quieres mover todos sus movimientos a otra categoría?';

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
  String get expense => 'Gasto';

  @override
  String get expenses => 'Gastos';

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
  String get noCategoriesDialogDescription => 'Antes de crear un nuevo movimiento es necesario crear una categoría, dale al botón para ir a la pantalla de creación de categorías.';

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
  String get validationsNotInRange => 'El valor no está dentro de los parametros esperados';

  @override
  String get validationsWrongFormat => 'El formato es incorrecto';
}
