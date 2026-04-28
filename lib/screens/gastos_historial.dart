import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/excell/convert_data_to_excel.dart';
import 'package:bills_control/l10n/app_localizations.dart';
import 'package:bills_control/screens/add_bils_history.dart';
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

  @override
  void initState() {
    super.initState();
    // Ejecutamos la lógica de reinicio de presupuestos antes de cargar datos
    BudgetLogic.checkAndResetBudgets().then((_) {
      if (mounted) {
        final ghCubit = context.read<GastosHistorialCubits>();
        ghCubit.clearGastosItems();
        ghCubit.getGastosItems();
        context.read<GastosCubits>().getGastos();
      }
    });
  }

  void _showAppropriateDialog(List<GastosItem> state) {
    if (_hasShownDialog || !mounted) return;

    final showAutoHelp = context.read<SettingsCubit>().state;
    if (showAutoHelp == null || !showAutoHelp) return;

    final filtered =
        state.where((element) => element.gastoId == widget.id).toList();

    // We only show the dialog once we are sure we have data or filtered is empty
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Cerrar Periodo"),
          content: Text("¿Estás seguro de cerrar el periodo de '${budget.motivo}'? Los gastos actuales se archivarán y el saldo se reiniciará."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await BudgetLogic.manualClosePeriod(budget);
                if (mounted) {
                  context.read<GastosCubits>().getGastos();
                  context.read<GastosHistorialCubits>().getGastosItems();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Periodo cerrado y archivado correctamente")),
                  );
                }
              },
              child: const Text("Confirmar Cierre", style: TextStyle(color: Colors.orangeAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  color: currentGasto.amount > 0 ? Colors.greenAccent : Colors.redAccent,
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
                final gastoC = state.firstWhere((element) => element.id == widget.id);
                double progress = 0;
                if (gastoC.initialAmount > 0) {
                  progress = (gastoC.initialAmount - gastoC.amount) / gastoC.initialAmount;
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
                    title: Text(
                        AppLocalizations.of(context)!.alert_help_history_title),
                    content: Text(AppLocalizations.of(context)!
                        .alert_help_history_content),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppLocalizations.of(context)!.alert_btn_ok),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.toolTip_add_gasto,
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
            tooltip: AppLocalizations.of(context)!.toolTip_export,
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
                // Header Fijo para el Título y Monto
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(vertical: 15.dp, horizontal: 20.dp),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.1),
                    border: Border(bottom: BorderSide(color: Colors.blueGrey, width: 1.dp)),
                  ),
                  child: BlocBuilder<GastosCubits, List<Gasto>>(
                    builder: (context, gState) {
                      try {
                        final currentGasto = gState.firstWhere((e) => e.id == widget.id);
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
                                  onPressed: () => _confirmClosePeriod(currentGasto),
                                  icon: Icon(Icons.history_toggle_off, size: 16.dp, color: Colors.orangeAccent),
                                  label: Text(
                                    "Cerrar Periodo", 
                                    style: TextStyle(color: Colors.orangeAccent, fontSize: 12.dp)
                                  ),
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(0.05),
                                    padding: EdgeInsets.symmetric(horizontal: 12.dp),
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
                // Lista de items expandida
                Expanded(
                  child: stateFilter.isEmpty
                      ? Center(
                          child: Text(
                            AppLocalizations.of(context)!.no_items_history,
                            style: const TextStyle(fontSize: 15),
                          ),
                        )
                      : ListView.builder(
                          itemCount: stateFilter.length,
                          itemBuilder: (context, index) {
                            final ghisto = context.read<GastosHistorialCubits>();
                            final gasto = context.read<GastosCubits>();
                            return Container(
                    margin: EdgeInsets.only(
                      top: 10.dp,
                      left: 5.dp,
                      right: 5.dp,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 1.8.dp),
                    ),
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(
                      top: 10.dp,
                      bottom: 10.dp,
                      left: 25.dp,
                      right: 10.dp,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, size: 15.dp),
                              tooltip: AppLocalizations.of(
                                context,
                              )!.toolTip_edit,
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
                              icon: Icon(Icons.delete, size: 15.dp),
                              tooltip: AppLocalizations.of(
                                context,
                              )!.toolTip_delete,
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
