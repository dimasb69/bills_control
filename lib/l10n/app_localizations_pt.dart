// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get tittle_name => 'Meus Orçamentos';

  @override
  String get no_items => 'Sem registros, pressione o botão + para adicionar um';

  @override
  String get no_items_history =>
      'Sem transações, pressione o botão + para adicionar uma';

  @override
  String get toolTip_items =>
      'Pressione sobre o orçamento para ver ou editar o histórico de gastos';

  @override
  String get toolTip_add_new => 'Adicionar novo';

  @override
  String get tootTip_history => 'View | Edit History';

  @override
  String get tittle_add_new => 'Novo Orçamento';

  @override
  String get etiqueta_motivo => 'Motivo / Conceito';

  @override
  String get etiqueta_monto => 'Valor a gerenciar';

  @override
  String get etiqueta_fecha => 'Data';

  @override
  String get etiqueta_guardar => 'Salvar';

  @override
  String get etiqueta_actualizar => 'Atualizar';

  @override
  String get etiqueta_cancelar => 'Cancelar';

  @override
  String get no_data_to_export => 'Não há dados para exportar';

  @override
  String get toolTip_export => 'Exportar para Excel';

  @override
  String get toolTip_add_gasto => 'Adicionar Gasto';

  @override
  String get tittle_add_new_history => 'Novo movimento para';

  @override
  String get etiueta_descripcion => 'Descrição do gasto';

  @override
  String get texto_hogar => 'Casa';

  @override
  String get texto_trabajo => 'Trabalho';

  @override
  String get texto_categoria => 'Categoria';

  @override
  String get etiqueta_monto_descuento => 'Valor a descontar';

  @override
  String get etiqueta_fecha_inicio => 'Data de início';

  @override
  String get toolTip_edit => 'Editar';

  @override
  String get toolTip_delete => 'Excluir';

  @override
  String get toolTip_agregar_saldo => 'Adicionar Saldo';

  @override
  String get texto_editar_gasto => 'Editar Gasto';

  @override
  String get texto_eliminar_gasto => 'Excluir Gasto';

  @override
  String get texto_eliminar_gasto_confirmacion =>
      'Tem certeza que deseja excluir este movimento?';

  @override
  String get texto_editar_presupuesto => 'Editar Orçamento';

  @override
  String get texto_eliminar_presupuesto => 'Excluir Orçamento';

  @override
  String get texto_eliminar_presupuesto_confirmacion =>
      'Tem certeza que deseja excluir o orçamento?';

  @override
  String get snack_text_caracteres_minimos =>
      'O conceito deve ter pelo menos 4 caracteres';

  @override
  String get snack_text_monto_minimo => 'O valor deve ser maior que 0';

  @override
  String get snack_text_caracteres_vacio =>
      'Revise os campos que esten vazios ou com menos de 4 caracteres';

  @override
  String get snack_text_abierto => 'O arquivo foi aberto';

  @override
  String get snack_text_error =>
      'Erro ao abrir o arquivo, valide que tenha instalado o visor de Excel';
}
