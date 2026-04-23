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
    // Limpiamos y cargamos los datos al iniciar la pantalla
    final ghCubit = context.read<GastosHistorialCubits>();
    ghCubit.clearGastosItems();
    ghCubit.getGastosItems();
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
        title: Row(
          children: [
            BlocBuilder<GastosCubits, List<Gasto>>(
              builder: (context, state) {
                final gastoC = state.firstWhere((element) => element.id == widget.id);
                return Row(
                  children: [
                    Text(
                      widget.name.length > 16 ? widget.name.substring(0, 16) : widget.name,
                      style: TextStyle(fontSize: 14.dp),
                    ),
                    Text(
                      " - ${gastoC.amount} \$",
                      style: TextStyle(
                        fontSize: 14.dp,
                        color: gastoC.amount > 0 ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
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
              if (stateFilter.isNotEmpty) {
                await convertDataToExcel(widget.id, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.no_data_to_export,
                    ),
                  ),
                );
              }
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
            if (stateFilter.isEmpty) {
              return Container(
                alignment: Alignment.center,
                height: 100.h,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.no_items_history,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
              );
            } else {
              return ListView.builder(
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
              );
            }
          },
        ),
        ),
      ),
      bottomNavigationBar: bottomDevName(),
    );
  }
}
