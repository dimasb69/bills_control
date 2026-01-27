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

class GastosHistorial extends StatelessWidget {
  const GastosHistorial({super.key, required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    context.read<GastosHistorialCubits>().getGastosItems();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.read<GastosCubits>().getGastos();
            Navigator.pop(context);
          },
        ),
        title: Text("Historial de Gastos $name"),
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
              await convertDataToExcel(id, context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GastosHistorialCubits, List<GastosItem>>(
          builder: (context, state) {
            if (state.isEmpty) {
              return Container(
                alignment: Alignment.center,
                height: 100.h,
                child: const Center(child: Text("Sin Movimientos")),
              );
            } else {
              return ListView.builder(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  if (state[index].gastoId == id) {
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
                                state[index].description,
                                style: TextStyle(
                                  fontSize: 5.w,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                state[index].category,
                                style: TextStyle(
                                  fontSize: 3.w,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${state[index].amount} \$",
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
                                      state[index].category;
                                  amountController.text = state[index].amount
                                      .toString();
                                  dateController.text = state[index].date
                                      .toString();
                                  final idBills = state[index].gastoId;
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      final currentAmount = state[index].amount;
                                      return AlertDialog(
                                        title: const Text("Editar gasto"),
                                        content: SizedBox(
                                          height: 15.h,
                                          width: 80.w,
                                          child: Column(
                                            children: [
                                              TextField(
                                                controller: categoryController,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: "Categoria",
                                                    ),
                                              ),
                                              TextField(
                                                controller:
                                                    descriptionController,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: "Concepto",
                                                    ),
                                              ),
                                              TextField(
                                                controller: dateController,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: "Fecha",
                                                    ),
                                              ),
                                              TextField(
                                                controller: amountController,
                                                decoration:
                                                    const InputDecoration(
                                                      labelText: "Monto",
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancelar"),
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
                                                      state[index].id,
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
                                                Navigator.pop(context);
                                              }
                                            },
                                            child: const Text("Actualizar"),
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
                                        title: const Text(
                                          "Eliminar movimiento",
                                        ),
                                        content: Text(
                                          "¿Está seguro de eliminar este movimiento?",
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Cancelar"),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              context
                                                  .read<GastosCubits>()
                                                  .sumGasto(
                                                    state[index].gastoId,
                                                    state[index].amount,
                                                  );
                                              context
                                                  .read<GastosHistorialCubits>()
                                                  .dellGastoItem(
                                                    state[index].id,
                                                  );
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Eliminar"),
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
                  } else {
                    return SizedBox(width: 0, height: 0);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
