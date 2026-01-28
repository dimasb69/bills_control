import 'package:bills_control/cubits/gastos_cubits.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:bills_control/excell/convert_data_to_excel.dart';
import 'package:bills_control/screens/add_bils_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

TextEditingController categoryController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateController = TextEditingController();
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
            icon: const Icon(Icons.share),
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
                child: const Center(child: Text("Sin Movimientos")),
              );
            } else {
              return ListView.builder(
                itemCount: stateFilter.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
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
                                fontSize: 3.w,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "${stateFilter[index].amount} \$",
                              style: TextStyle(
                                fontSize: 3.w,
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
                                categoryController.text =
                                    stateFilter[index].category;
                                amountController.text = stateFilter[index]
                                    .amount
                                    .toString();
                                descriptionController.text =
                                    stateFilter[index].description;
                                dateController.text = stateFilter[index].date
                                    .toString();
                                final idBills = stateFilter[index].gastoId;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    final currentAmount =
                                        stateFilter[index].amount;
                                    return AlertDialog(
                                      title: Center(
                                        child: Text("Editar gasto"),
                                      ),
                                      content: SizedBox(
                                        height: 33.h,
                                        width: 80.w,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: descriptionController,
                                              maxLength: 30,
                                              decoration: const InputDecoration(
                                                labelText: "Concepto",
                                              ),
                                            ),
                                            TextField(
                                              controller: categoryController,
                                              maxLength: 15,
                                              decoration: const InputDecoration(
                                                labelText: "Categoria",
                                              ),
                                            ),
                                            TextField(
                                              controller: dateController,
                                              decoration: const InputDecoration(
                                                labelText: "Fecha",
                                              ),
                                            ),
                                            TextField(
                                              controller: amountController,
                                              decoration: const InputDecoration(
                                                labelText: "Monto",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          //mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.black26,
                                              ),
                                              child: const Text(
                                                "Cancelar",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                if (double.parse(
                                                      amountController.text,
                                                    ) !=
                                                    currentAmount) {
                                                  await sumarGasto(
                                                    idBills,
                                                    currentAmount,
                                                  );
                                                  if (context.mounted) {
                                                    context
                                                        .read<GastosCubits>()
                                                        .sumGasto(
                                                          idBills,
                                                          currentAmount,
                                                        );
                                                  }
                                                  await restarGasto(
                                                    idBills,
                                                    double.parse(
                                                      amountController.text,
                                                    ),
                                                  );
                                                }
                                                if (context.mounted) {
                                                  context
                                                      .read<
                                                        GastosHistorialCubits
                                                      >()
                                                      .updGastoItem(
                                                        stateFilter[index].id,
                                                        idBills,
                                                        descriptionController
                                                            .text,
                                                        double.parse(
                                                          amountController.text,
                                                        ),
                                                        DateTime.parse(
                                                          dateController.text,
                                                        ),
                                                        categoryController.text,
                                                        '',
                                                      );
                                                  stateFilter = [];
                                                  Navigator.pop(context);
                                                }
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.black26,
                                              ),
                                              child: const Text(
                                                "Actualizar",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, size: 15.dp),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Center(
                                        child: Text("Eliminar movimiento"),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "¿Está seguro de eliminar este movimiento?",
                                          ),
                                          Text(
                                            stateFilter[index].description,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.black26,
                                              ),
                                              child: const Text(
                                                "Cancelar",
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () async {
                                                context
                                                    .read<GastosCubits>()
                                                    .sumGasto(
                                                      stateFilter[index]
                                                          .gastoId,
                                                      stateFilter[index].amount,
                                                    );
                                                context
                                                    .read<
                                                      GastosHistorialCubits
                                                    >()
                                                    .dellGastoItem(
                                                      stateFilter[index].id,
                                                    );
                                                Navigator.pop(context);
                                              },
                                              style: TextButton.styleFrom(
                                                backgroundColor: Colors.black26,
                                              ),
                                              child: const Text(
                                                "Eliminar",
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                );
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
    );
  }
}
