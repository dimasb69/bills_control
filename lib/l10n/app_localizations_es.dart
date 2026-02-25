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
  String get no_items => 'Sin registros, presiona el boton + para agregar uno';

  @override
  String get no_items_history =>
      'Sin transacciones, presiona el boton + para agregar una';

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
}
