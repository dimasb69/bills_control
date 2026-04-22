// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get tittle_name => 'Mis Presupuestos';

  @override
  String get no_items =>
      'Sin cuentas o presupuestos, presiona el boton + para agregar uno';

  @override
  String get no_items_history =>
      'Sin gastos, presiona el boton + para agregar uno';

  @override
  String get toolTip_items =>
      'Presiona sobre el presupuesto para ver o editar el historial de gastos';

  @override
  String get toolTip_add_new => 'Agregar nuevo';

  @override
  String get tootTip_history => 'View | Edit History';

  @override
  String get tittle_add_new => 'Nuevo Presupuesto';

  @override
  String get etiqueta_motivo => 'Motivo / Concepto';

  @override
  String get hint_motivo => 'Ej: Vacaciones, Viaje de trabajo, Gastos del mes';

  @override
  String get etiqueta_monto => 'Monto a manejar';

  @override
  String get etiqueta_fecha => 'Fecha';

  @override
  String get etiqueta_guardar => 'Guardar';

  @override
  String get etiqueta_actualizar => 'Actualizar';

  @override
  String get etiqueta_cancelar => 'Cancelar';

  @override
  String get no_data_to_export => 'No hay datos para exportar';

  @override
  String get toolTip_export => 'Exportar a Excel';

  @override
  String get toolTip_add_gasto => 'Agregar Gasto';

  @override
  String get tittle_add_new_history => 'Nuevo movimiento para';

  @override
  String get etiueta_descripcion => 'Descripcion del gasto';

  @override
  String get texto_hogar => 'Hogar';

  @override
  String get texto_trabajo => 'Trabajo';

  @override
  String get texto_categoria => 'Categoria';

  @override
  String get etiqueta_monto_descuento => 'Monto a descontar';

  @override
  String get etiqueta_fecha_inicio => 'Fecha de inicio';

  @override
  String get toolTip_edit => 'Editar';

  @override
  String get toolTip_delete => 'Eliminar';

  @override
  String get toolTip_agregar_saldo => 'Agregar Saldo';

  @override
  String get texto_editar_gasto => 'Editar Gasto';

  @override
  String get texto_eliminar_gasto => 'Eliminar Gasto';

  @override
  String get texto_eliminar_gasto_confirmacion =>
      '¿Estás seguro de eliminar este movimiento?';

  @override
  String get texto_editar_presupuesto => 'Editar Presupuesto';

  @override
  String get texto_eliminar_presupuesto => 'Eliminar Presupuesto';

  @override
  String get texto_eliminar_presupuesto_confirmacion =>
      '¿Estás seguro de eliminar el presupuesto?';

  @override
  String get snack_text_caracteres_minimos =>
      'El concepto debe tener al menos 4 caracteres';

  @override
  String get snack_text_monto_minimo => 'El monto debe ser mayor a 0';

  @override
  String get snack_text_caracteres_vacio =>
      'Revise los campos que esten vacios o con menos de 4 caracteres';

  @override
  String get snack_text_abierto => 'El archivo se ha abierto';

  @override
  String get snack_text_error =>
      'Error al abrir el archivo, valida que tienes instalado el visor de Excel';

  @override
  String get alert_no_items_title => '¡Bienvenido!';

  @override
  String get alert_no_items_content =>
      'Para comenzar, presiona el botón + en la esquina superior para crear tu primer presupuesto o cuenta.';

  @override
  String get alert_no_items_history_title => '¡Añade tu primer gasto!';

  @override
  String get alert_no_items_history_content =>
      'Presiona el botón + para registrar tu primer movimiento en este presupuesto.';

  @override
  String get alert_btn_ok => 'Entendido';

  @override
  String get alert_help_home_title => 'Guía de Presupuestos';

  @override
  String get alert_help_home_content =>
      'Presiona sobre un presupuesto para ver su historial de gastos. Usa el icono de lápiz para editar, el bote para eliminar y el icono + para añadir más dinero al presupuesto.';

  @override
  String get alert_help_history_title => 'Guía de Movimientos';

  @override
  String get alert_help_history_content =>
      'Presiona el botón + arriba para registrar un nuevo gasto. Puedes editar o eliminar gastos existentes y exportar el historial a Excel.';

  @override
  String get texto_personalizado => 'Personalizado';

  @override
  String get tooltip_manage_categories => 'Gestionar categorías';

  @override
  String get label_new_category => 'Nueva categoría';

  @override
  String get tooltip_auto_help => 'Ayuda automática';

  @override
  String get category_notice =>
      'En la pestaña \'Personalizado\' puedes crear y gestionar tus propias categorías.';
}
