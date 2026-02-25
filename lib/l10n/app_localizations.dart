import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
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
/// import 'l10n/app_localizations.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Titulo de la app
  ///
  /// In en, this message translates to:
  /// **'My Budget'**
  String get tittle_name;

  /// Mensaje cuando no hay registros
  ///
  /// In en, this message translates to:
  /// **'No items, press + to add one'**
  String get no_items;

  /// Mensaje cuando no hay registros en el historial
  ///
  /// In en, this message translates to:
  /// **'No transactions, press + to add one'**
  String get no_items_history;

  /// No description provided for @toolTip_items.
  ///
  /// In en, this message translates to:
  /// **'Press on a items to edit or view history of expenses '**
  String get toolTip_items;

  /// No description provided for @toolTip_add_new.
  ///
  /// In en, this message translates to:
  /// **'Add new'**
  String get toolTip_add_new;

  /// tool tip del boton history
  ///
  /// In en, this message translates to:
  /// **'View | Edit History'**
  String get tootTip_history;

  /// Titulo Agregar nuevo
  ///
  /// In en, this message translates to:
  /// **'New Bills'**
  String get tittle_add_new;

  /// Etiqueta del TextEdit Motivo
  ///
  /// In en, this message translates to:
  /// **'Concept / Reason'**
  String get etiqueta_motivo;

  /// Etiqueta del TextEdit Monto
  ///
  /// In en, this message translates to:
  /// **'Amount to manage'**
  String get etiqueta_monto;

  /// Etiqueta del TextEdit Fecha
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get etiqueta_fecha;

  /// Etiqueta del boton Guardar
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get etiqueta_guardar;

  /// Etiqueta del boton Actualizar
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get etiqueta_actualizar;

  /// Etiqueta del boton Cancelar
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get etiqueta_cancelar;

  /// Mensaje cuando no hay datos para exportar
  ///
  /// In en, this message translates to:
  /// **'No data to export'**
  String get no_data_to_export;

  /// tool tip del boton exportar
  ///
  /// In en, this message translates to:
  /// **'Export to Excel'**
  String get toolTip_export;

  /// tool tip del boton agregar gasto
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get toolTip_add_gasto;

  /// Titulo Agregar nuevo movimiento
  ///
  /// In en, this message translates to:
  /// **'New movement to'**
  String get tittle_add_new_history;

  /// Etiqueta del TextEdit Descripcion
  ///
  /// In en, this message translates to:
  /// **'Description of the expense'**
  String get etiueta_descripcion;

  /// No description provided for @texto_hogar.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get texto_hogar;

  /// No description provided for @texto_trabajo.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get texto_trabajo;

  /// No description provided for @texto_categoria.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get texto_categoria;

  /// No description provided for @etiqueta_monto_descuento.
  ///
  /// In en, this message translates to:
  /// **'Amount to discount'**
  String get etiqueta_monto_descuento;

  /// No description provided for @etiqueta_fecha_inicio.
  ///
  /// In en, this message translates to:
  /// **'Start date'**
  String get etiqueta_fecha_inicio;

  /// tool tip del boton editar
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get toolTip_edit;

  /// tool tip del boton eliminar
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get toolTip_delete;

  /// tool tip del boton agregar saldo
  ///
  /// In en, this message translates to:
  /// **'Add Balance'**
  String get toolTip_agregar_saldo;

  /// texto del titulo editar gasto
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get texto_editar_gasto;

  /// texto del titulo eliminar gasto
  ///
  /// In en, this message translates to:
  /// **'Delete Expense'**
  String get texto_eliminar_gasto;

  /// texto de confirmacion eliminar gasto
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this expense?'**
  String get texto_eliminar_gasto_confirmacion;

  /// texto del titulo editar presupuesto
  ///
  /// In en, this message translates to:
  /// **'Edit Budget'**
  String get texto_editar_presupuesto;

  /// texto del titulo eliminar presupuesto
  ///
  /// In en, this message translates to:
  /// **'Delete Budget'**
  String get texto_eliminar_presupuesto;

  /// texto de confirmacion eliminar presupuesto
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this budget?'**
  String get texto_eliminar_presupuesto_confirmacion;
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
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
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
