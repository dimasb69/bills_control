import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/excell/convert_data_to_excel.dart';
import 'package:bills_control/screens/add_bils_history.dart';
import 'package:bills_control/widgets/dev_name.dart';
import 'package:bills_control/widgets/hystory_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

List<GastosItem> stateFilter = [];
int count = 0;

class GastosHistorial extends StatelessWidget {
  const GastosHistorial({super.key, required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    stateFilter = [];
    if (count == 0) {
      if (context.read<GastosHistorialCubits>().state.isNotEmpty) {
        context.read<GastosHistorialCubits>().clearGastosItems();
      } else {
        context.read<GastosHistorialCubits>().getGastosItems();
      }
      count++;
    }
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
                final gastoC = state.firstWhere((element) => element.id == id);
                return Row(
                  children: [
                    Text(name, style: TextStyle(fontSize: 14.dp)),
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
            tooltip: "Agregar gasto",
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GastosHistorialAdd(id: id, name: name);
                  },
                ),
              );
            },
          ),
          IconButton(
            tooltip: "Exportar a Excel",
            icon: const Icon(Icons.file_open),
            onPressed: () async {
              if (stateFilter.isNotEmpty) {
                await convertDataToExcel(id, context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("No hay datos para exportar")),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GastosHistorialCubits, List<GastosItem>>(
          builder: (context, state) {
            for (var data in state) {
              if (data.gastoId == id) {
                stateFilter.add(data);
              }
            }
            if (stateFilter.isEmpty) {
              return Container(
                alignment: Alignment.center,
                height: 100.h,
                child: const Center(
                  child: Text(
                    "No existen movimientos, presiona el boton + para agregar uno",
                    style: TextStyle(fontSize: 15),
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
      bottomNavigationBar: bottomDevName(),
    );
  }
}
