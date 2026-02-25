import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/screens/add_bils.dart';
import 'package:bills_control/screens/gastos_historial.dart';
import 'package:bills_control/widgets/bils_widgets.dart';
import 'package:bills_control/widgets/dev_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

import '../l10n/app_localizations.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final gCubit = context.read<GastosCubits>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tittle_name),
        actions: [
          IconButton(
            icon: const Icon(Icons.help),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      gCubit.state.isEmpty
                          ? AppLocalizations.of(context)!.no_items
                          : AppLocalizations.of(context)!.toolTip_items,
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            tooltip: AppLocalizations.of(context)!.toolTip_add_new,
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewControl()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GastosCubits, List<Gasto>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return Container(
                alignment: Alignment.center,
                height: 100.h,
                child: Center(
                  child: Padding(
                    padding: EdgeInsetsGeometry.only(left: 10, right: 10),
                    child: Text(
                      AppLocalizations.of(context)!.no_items,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: 10.dp,
                      left: 5.dp,
                      right: 5.dp,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 1.8.dp),
                      borderRadius: BorderRadius.circular(10.dp),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                      top: 10.dp,
                      bottom: 10.dp,
                      right: 10.dp,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GastosHistorial(
                                  id: state[index].id,
                                  name: state[index].motivo,
                                ),
                              ),
                            );
                          },
                          child: Tooltip(
                            message: AppLocalizations.of(
                              context,
                            )!.tootTip_history,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 18.dp),
                              width: 70.w,
                              height: 20.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state[index].motivo,
                                    style: TextStyle(
                                      fontSize: 5.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "${state[index].amount} \$",
                                    style: TextStyle(
                                      fontSize: 4.2.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                editGasto(state, index, context, gCubit);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.add, size: 15.dp),
                              tooltip: AppLocalizations.of(
                                context,
                              )!.toolTip_agregar_saldo,
                              onPressed: () {
                                agregarSaldo(state, index, context, gCubit);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, size: 15.dp),
                              tooltip: AppLocalizations.of(
                                context,
                              )!.toolTip_delete,
                              onPressed: () {
                                deleteGasto(state, index, context, gCubit);
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
      bottomNavigationBar: bottomDevName(),
    );
  }
}
