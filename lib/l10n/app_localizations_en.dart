// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get tittle_name => 'My Budget';

  @override
  String get no_items => 'No accounts or budgets, press + to add one';

  @override
  String get no_items_history => 'No expenses, press + to add one';

  @override
  String get toolTip_items =>
      'Press on a items to edit or view history of expenses ';

  @override
  String get toolTip_add_new => 'Add new';

  @override
  String get tootTip_history => 'View | Edit History';

  @override
  String get tittle_add_new => 'New Budget';

  @override
  String get etiqueta_motivo => 'Concept / Reason';

  @override
  String get hint_motivo => 'Ex: Vacation, Work trip, Monthly expenses';

  @override
  String get etiqueta_monto => 'Amount to manage';

  @override
  String get etiqueta_fecha => 'Date';

  @override
  String get etiqueta_guardar => 'Save';

  @override
  String get etiqueta_actualizar => 'Update';

  @override
  String get etiqueta_cancelar => 'Cancel';

  @override
  String get no_data_to_export => 'No data to export';

  @override
  String get toolTip_export => 'Export to Excel';

  @override
  String get toolTip_add_gasto => 'Add Expense';

  @override
  String get tittle_add_new_history => 'New movement to';

  @override
  String get etiueta_descripcion => 'Description of the expense';

  @override
  String get texto_hogar => 'Home';

  @override
  String get texto_trabajo => 'Work';

  @override
  String get texto_categoria => 'Category';

  @override
  String get etiqueta_monto_descuento => 'Amount to discount';

  @override
  String get etiqueta_fecha_inicio => 'Start date';

  @override
  String get toolTip_edit => 'Edit';

  @override
  String get toolTip_delete => 'Delete';

  @override
  String get toolTip_agregar_saldo => 'Add Balance';

  @override
  String get texto_editar_gasto => 'Edit Expense';

  @override
  String get texto_eliminar_gasto => 'Delete Expense';

  @override
  String get texto_eliminar_gasto_confirmacion =>
      'Are you sure you want to delete this expense?';

  @override
  String get texto_editar_presupuesto => 'Edit Budget';

  @override
  String get texto_eliminar_presupuesto => 'Delete Budget';

  @override
  String get texto_eliminar_presupuesto_confirmacion =>
      'Are you sure you want to delete this budget?';

  @override
  String get snack_text_caracteres_minimos =>
      'The concept must have at least 4 characters';

  @override
  String get snack_text_monto_minimo => 'The amount must be greater than 0';

  @override
  String get snack_text_caracteres_vacio =>
      'Check ther are not empty fields or contains less than 4 characters';

  @override
  String get snack_text_abierto => 'The file has been opened';

  @override
  String get snack_text_error =>
      'Error opening the file, validate has Excel Visor installed';

  @override
  String get alert_no_items_title => 'Welcome!';

  @override
  String get alert_no_items_content =>
      'To get started, press the + button in the top corner to create your first budget or account.';

  @override
  String get alert_no_items_history_title => 'Add your first expense!';

  @override
  String get alert_no_items_history_content =>
      'Press the + button to record your first expense in this budget.';

  @override
  String get alert_btn_ok => 'Got it';

  @override
  String get alert_help_home_title => 'Budget Guide';

  @override
  String get alert_help_home_content =>
      'Tap on a budget to view its expense history. Use the pencil to edit, the bin to delete, and the + icon to add more funds to the budget.';

  @override
  String get alert_help_history_title => 'Expense Guide';

  @override
  String get alert_help_history_content =>
      'Tap the + button above to register a new expense. You can edit or delete existing expenses and export the history to Excel.';
}
