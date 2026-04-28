import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart' hide deleteGastoItem;
import 'package:bills_control/excell/convert_data_to_excel.dart';
import 'package:bills_control/l10n/app_localizations.dart';
import 'package:bills_control/screens/add_bils_history.dart';
import 'package:bills_control/screens/period_history_viewer.dart';
import 'package:bills_control/widgets/dev_name.dart';
import 'package:bills_control/widgets/hystory_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:bills_control/logic/budget_logic.dart';

class GastosHistorial extends StatefulWidget {
  const GastosHistorial({Key? key, required this.id, required this.name})
      : super(key: key);

  final int id;
  final String name;

  @override
  State<GastosHistorial> createState() => _GastosHistorialState();
}

class _GastosHistorialState extends State<GastosHistorial> {
  bool _hasShownDialog = false;
  List<GastosItem> stateFilter = [];
  List<GastosHistorialCerradoData> _closedHistory = [];

  @override
  void initState() {
    super.initState();
    BudgetLogic.checkAndResetBudgets().then((_) {
      if (mounted) {
        final ghCubit = context.read<GastosHistorialCubits>();
        ghCubit.clearGastosItems();
        ghCubit.getGastosItems();
        context.read<GastosCubits>().getGastos();
        _loadClosedHistory();
      }
    });
  }

  Future<void> _loadClosedHistory() async {
    final history = await readHistoryCerradoByGastoId(widget.id);
    if (mounted) {
      setState(() {
        _closedHistory = List.from(history.reversed);
      });
    }
  }

  void _showAppropriateDialog(List<GastosItem> state) {
    if (_hasShownDialog || !mounted) return;

    final showAutoHelp = context.read<SettingsCubit>().state;
    if (showAutoHelp == null || !showAutoHelp) return;

    final filtered =
        state.where((element) => element.gastoId == widget.id).toList();

    _hasShownDialog = true;

    if (filtered.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title:
                Text(AppLocalizations.of(context)!.alert_no_items_history_title),
            content: Text(
                AppLocalizations.of(context)!.alert_no_items_history_content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.alert_btn_ok),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.alert_help_history_title),
            content:
                Text(AppLocalizations.of(context)!.alert_help_history_content),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.alert_btn_ok),
              ),
            ],
          );
        },
      );
    }
  }

  void _confirmClosePeriod(Gasto budget) {
    final l10n = AppLocalizations.of(context)!;
    final isAnnual = budget.type == 'annual';
    final now = DateTime.now();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(isAnnual ? l10n.cerrar_anio : l10n.cerrar_mes),
          content: Text(
            isAnnual
                ? l10n.confirm_cerrar_anio(now.year.toString())
                : l10n.confirm_cerrar_mes(budget.motivo),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.etiqueta_cancelar),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(ctx);
                if (isAnnual) {
                  await BudgetLogic.manualCloseAnnualPeriod(budget);
                } else {
                  await BudgetLogic.manualCloseMonthlyPeriod(budget);
                }
                if (mounted) {
                  context.read<GastosCubits>().getGastos();
                  context.read<GastosHistorialCubits>().getGastosItems();
                  await _loadClosedHistory();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isAnnual
                            ? 'Año cerrado y archivado correctamente'
                            : 'Periodo cerrado y archivado correctamente',
                      ),
                    ),
                  );
                }
              },
              child: Text(
                isAnnual ? l10n.cerrar_anio : l10n.cerrar_mes,
                style: const TextStyle(color: Colors.orangeAccent),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeletePeriod(GastosHistorialCerradoData entry) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.eliminar_periodo_titulo),
        content: Text(l10n.eliminar_periodo_advertencia),
        actions: [
          // Export first
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              exportArchivedPeriod(entry, widget.name, context);
            },
            child: Text(
              l10n.btn_exportar_primero,
              style: const TextStyle(color: Colors.blueAccent),
            ),
          ),
          // Delete anyway
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await deleteHistoryCerrado(entry.id);
              await _loadClosedHistory();
            },
            child: Text(
              l10n.btn_eliminar_de_todas_formas,
              style: const TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreviousPeriodsSection(AppLocalizations l10n) {
    return ExpansionTile(
      title: Text(
        l10n.periodos_anteriores,
        style: TextStyle(
          fontSize: 13.dp,
          fontWeight: FontWeight.w600,
          color: Colors.blueGrey[200],
        ),
      ),
      leading: Icon(Icons.history, color: Colors.blueGrey[300], size: 18.dp),
      collapsedBackgroundColor: Colors.blueGrey.withOpacity(0.08),
      backgroundColor: Colors.blueGrey.withOpacity(0.05),
      children: _closedHistory.isEmpty
          ? [
              Padding(
                padding: EdgeInsets.all(12.dp),
                child: Text(
                  l10n.no_periodos_anteriores,
                  style:
                      TextStyle(color: Colors.white38, fontSize: 12.dp),
                ),
              ),
            ]
          : _closedHistory.map((entry) {
              return ListTile(
                dense: true,
                title: Text(
                  entry.periodLabel,
                  style: TextStyle(fontSize: 13.dp, color: Colors.white70),
                ),
                subtitle: Text(
                  '${l10n.total_gastado_label}: ${entry.totalSpent.toStringAsFixed(2)} \$',
                  style: TextStyle(fontSize: 11.dp, color: Colors.white38),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // View button
                    IconButton(
                      icon: Icon(Icons.visibility_outlined,
                          size: 18.dp, color: Colors.blueAccent),
                      tooltip: 'Ver periodo',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PeriodHistoryViewer(
                              entry: entry,
                              budgetName: widget.name,
                            ),
                          ),
                        );
                      },
                    ),
                    // Delete button
                    IconButton(
                      icon: Icon(Icons.delete_outline,
                          size: 18.dp, color: Colors.redAccent),
                      tooltip: l10n.eliminar_periodo_titulo,
                      onPressed: () => _confirmDeletePeriod(entry),
                    ),
                  ],
                ),
              );
            }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.read<GastosCubits>().getGastos();
            Navigator.pop(context);
          },
        ),
        title: BlocBuilder<GastosCubits, List<Gasto>>(
          builder: (context, state) {
            try {
              final currentGasto = state.firstWhere((e) => e.id == widget.id);
              return Text(
                "${currentGasto.amount.toStringAsFixed(2)} \$",
                style: TextStyle(
                  fontSize: 16.dp,
                  fontWeight: FontWeight.bold,
                  color: currentGasto.amount > 0
                      ? Colors.greenAccent
                      : Colors.redAccent,
                ),
              );
            } catch (e) {
              return const SizedBox();
            }
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: BlocBuilder<GastosCubits, List<Gasto>>(
            builder: (context, state) {
              try {
                final gastoC =
                    state.firstWhere((element) => element.id == widget.id);
                double progress = 0;
                if (gastoC.initialAmount > 0) {
                  progress = (gastoC.initialAmount - gastoC.amount) /
                      gastoC.initialAmount;
                }
                return LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  backgroundColor: Colors.white24,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress >= 1.0 ? Colors.red : Colors.greenAccent,
                  ),
                );
              } catch (e) {
                return const LinearProgressIndicator(value: 0);
              }
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(l10n.alert_help_history_title),
                    content: Text(l10n.alert_help_history_content),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(l10n.alert_btn_ok),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            tooltip: l10n.toolTip_add_gasto,
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GastosHistorialAdd(id: widget.id, name: widget.name);
                  },
                ),
              );
            },
          ),
          IconButton(
            tooltip: l10n.toolTip_export,
            icon: const Icon(Icons.file_open),
            onPressed: () async {
              await convertDataToExcel(widget.id, context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<GastosHistorialCubits, List<GastosItem>>(
              listener: (context, state) {
                _showAppropriateDialog(state);
              },
            ),
            BlocListener<SettingsCubit, bool?>(
              listener: (context, showAutoHelp) {
                if (showAutoHelp != null) {
                  _showAppropriateDialog(
                      context.read<GastosHistorialCubits>().state);
                }
              },
            ),
          ],
          child: BlocBuilder<GastosHistorialCubits, List<GastosItem>>(
            builder: (context, state) {
              stateFilter = [];
              for (var data in state) {
                if (data.gastoId == widget.id) {
                  stateFilter.add(data);
                }
              }

              return Column(
                children: [
                  // ── Fixed header: name + close button ──────────────────
                  Container(
                    width: 100.w,
                    padding: EdgeInsets.symmetric(
                        vertical: 15.dp, horizontal: 20.dp),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.withOpacity(0.1),
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.blueGrey, width: 1.dp)),
                    ),
                    child: BlocBuilder<GastosCubits, List<Gasto>>(
                      builder: (context, gState) {
                        try {
                          final currentGasto =
                              gState.firstWhere((e) => e.id == widget.id);
                          return Column(
                            children: [
                              Text(
                                widget.name,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 15.dp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white70,
                                ),
                              ),
                              if (currentGasto.type != 'normal')
                                Padding(
                                  padding: EdgeInsets.only(top: 10.dp),
                                  child: TextButton.icon(
                                    onPressed: () =>
                                        _confirmClosePeriod(currentGasto),
                                    icon: Icon(
                                      Icons.history_toggle_off,
                                      size: 16.dp,
                                      color: Colors.orangeAccent,
                                    ),
                                    label: Text(
                                      currentGasto.type == 'annual'
                                          ? l10n.cerrar_anio
                                          : l10n.cerrar_mes,
                                      style: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 12.dp,
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Colors.white.withOpacity(0.05),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.dp),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        } catch (e) {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                  // ── Current items list ──────────────────────────────────
                  Expanded(
                    child: stateFilter.isEmpty
                        ? Center(
                            child: Text(
                              l10n.no_items_history,
                              style: const TextStyle(fontSize: 15),
                            ),
                          )
                        : ListView.builder(
                            itemCount: stateFilter.length,
                            itemBuilder: (context, index) {
                              final ghisto =
                                  context.read<GastosHistorialCubits>();
                              final gasto = context.read<GastosCubits>();
                              return Container(
                                margin: EdgeInsets.only(
                                  top: 10.dp,
                                  left: 5.dp,
                                  right: 5.dp,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.blueGrey, width: 1.8.dp),
                                ),
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.only(
                                  top: 10.dp,
                                  bottom: 10.dp,
                                  left: 25.dp,
                                  right: 10.dp,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          stateFilter[index].description,
                                          style: TextStyle(
                                            fontSize: 5.w,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          stateFilter[index].category,
                                          style: TextStyle(
                                            fontSize: 3.5.w,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "${stateFilter[index].amount} \$",
                                          style: TextStyle(
                                            fontSize: 4.w,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon:
                                              Icon(Icons.edit, size: 15.dp),
                                          tooltip: l10n.toolTip_edit,
                                          onPressed: () {
                                            editGastoItem(
                                              context,
                                              index,
                                              stateFilter,
                                              ghisto,
                                              gasto,
                                            );
                                            stateFilter = [];
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete,
                                              size: 15.dp),
                                          tooltip: l10n.toolTip_delete,
                                          onPressed: () {
                                            deleteGastoItem(
                                              context,
                                              stateFilter[index].gastoId,
                                              stateFilter[index].id,
                                              index,
                                              stateFilter,
                                              ghisto,
                                              gasto,
                                            );
                                            stateFilter = [];
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  // ── Previous periods section ────────────────────────────
                  _buildPreviousPeriodsSection(l10n),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: bottomDevName(),
    );
  }
}
