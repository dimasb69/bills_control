import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_pt.dart';

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
    Locale('pt'),
  ];

  /// Titulo de la app
  ///
  /// In en, this message translates to:
  /// **'My Budget'**
  String get tittle_name;

  /// Mensaje cuando no hay registros
  ///
  /// In en, this message translates to:
  /// **'No accounts or budgets, press + to add one'**
  String get no_items;

  /// Mensaje cuando no hay registros en el historial
  ///
  /// In en, this message translates to:
  /// **'No expenses, press + to add one'**
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
  /// **'New Budget'**
  String get tittle_add_new;

  /// Etiqueta del TextEdit Motivo
  ///
  /// In en, this message translates to:
  /// **'Concept / Reason'**
  String get etiqueta_motivo;

  /// No description provided for @hint_motivo.
  ///
  /// In en, this message translates to:
  /// **'Ex: Vacation, Work trip, Monthly expenses'**
  String get hint_motivo;

  /// Etiqueta del TextEdit Monto
  ///
  /// In en, this message translates to:
  /// **'Amount to manage'**
  String get etiqueta_monto;

  /// Header for the spent amount column in Excel
  ///
  /// In en, this message translates to:
  /// **'Spent Amount'**
  String get excel_header_monto_gastado;

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

  /// texto de snack caracteres minimos
  ///
  /// In en, this message translates to:
  /// **'The concept must have at least 4 characters'**
  String get snack_text_caracteres_minimos;

  /// texto de snack monto minimo
  ///
  /// In en, this message translates to:
  /// **'The amount must be greater than 0'**
  String get snack_text_monto_minimo;

  /// texto de snack caracteres minimos
  ///
  /// In en, this message translates to:
  /// **'Check ther are not empty fields or contains less than 4 characters'**
  String get snack_text_caracteres_vacio;

  /// texto de snack abierto
  ///
  /// In en, this message translates to:
  /// **'The file has been opened'**
  String get snack_text_abierto;

  /// texto de snack error
  ///
  /// In en, this message translates to:
  /// **'Error opening the file, validate has Excel Visor installed'**
  String get snack_text_error;

  /// No description provided for @alert_no_items_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get alert_no_items_title;

  /// No description provided for @alert_no_items_content.
  ///
  /// In en, this message translates to:
  /// **'To get started, press the + button in the top corner to create your first budget or account.'**
  String get alert_no_items_content;

  /// No description provided for @alert_no_items_history_title.
  ///
  /// In en, this message translates to:
  /// **'Add your first expense!'**
  String get alert_no_items_history_title;

  /// No description provided for @alert_no_items_history_content.
  ///
  /// In en, this message translates to:
  /// **'Press the + button to record your first expense in this budget.'**
  String get alert_no_items_history_content;

  /// No description provided for @alert_btn_ok.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get alert_btn_ok;

  /// No description provided for @alert_help_home_title.
  ///
  /// In en, this message translates to:
  /// **'Budget Guide'**
  String get alert_help_home_title;

  /// No description provided for @alert_help_home_content.
  ///
  /// In en, this message translates to:
  /// **'Tap on a budget to view its expense history. Use the pencil to edit, the bin to delete, and the + icon to add more funds to the budget.'**
  String get alert_help_home_content;

  /// No description provided for @alert_help_history_title.
  ///
  /// In en, this message translates to:
  /// **'Expense Guide'**
  String get alert_help_history_title;

  /// No description provided for @alert_help_history_content.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button above to register a new expense. You can edit or delete existing expenses and export the history to Excel.'**
  String get alert_help_history_content;

  /// No description provided for @texto_personalizado.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get texto_personalizado;

  /// No description provided for @tooltip_manage_categories.
  ///
  /// In en, this message translates to:
  /// **'Manage categories'**
  String get tooltip_manage_categories;

  /// No description provided for @label_new_category.
  ///
  /// In en, this message translates to:
  /// **'New category'**
  String get label_new_category;

  /// No description provided for @tooltip_auto_help.
  ///
  /// In en, this message translates to:
  /// **'Automatic help'**
  String get tooltip_auto_help;

  /// No description provided for @category_notice.
  ///
  /// In en, this message translates to:
  /// **'In the \'Custom\' tab you can create and manage your own categories.'**
  String get category_notice;
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
      <String>['en', 'es', 'pt'].contains(locale.languageCode);

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
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
