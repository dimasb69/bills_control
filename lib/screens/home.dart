import 'package:bills_control/cubits/gastos_cubits.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/screens/add_bils.dart';
import 'package:bills_control/screens/gastos_historial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

TextEditingController motivoController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController newAmountController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController idUpdateController = TextEditingController();

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Control de Gastos"),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
          IconButton(
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
                child: const Center(child: Text("No hay gastos")),
              );
            } else {
              return ListView.builder(
                itemCount: state.length,
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
                        Tooltip(
                          message: "Ver/Editar historial",
                          child: GestureDetector(
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

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
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
                                    fontSize: 3.w,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, size: 15.dp),
                              onPressed: () {
                                idUpdateController.text = state[index].id
                                    .toString();
                                motivoController.text = state[index].motivo;
                                amountController.text = state[index].amount
                                    .toString();
                                final fecha = state[index].date;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Editar gasto"),
                                      content: SizedBox(
                                        height: 15.h,
                                        width: 80.w,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: motivoController,
                                              decoration: const InputDecoration(
                                                labelText: "Motivo",
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
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancelar"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<GastosCubits>()
                                                .updGasto(
                                                  int.parse(
                                                    idUpdateController.text,
                                                  ),
                                                  motivoController.text,
                                                  double.parse(
                                                    amountController.text,
                                                  ),
                                                  fecha,
                                                );
                                            Navigator.pop(context);
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
                              icon: Icon(Icons.add, size: 15.dp),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Agregar saldo ${state[index].motivo}",
                                      ),
                                      content: SizedBox(
                                        height: 15.h,
                                        width: 80.w,
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller: newAmountController,
                                              decoration: const InputDecoration(
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
                                            if (context.mounted) {
                                              context
                                                  .read<GastosCubits>()
                                                  .sumGasto(
                                                    state[index].id,
                                                    double.parse(
                                                      newAmountController.text,
                                                    ),
                                                  );
                                              newAmountController.clear();
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
                                      title: const Text("Eliminar gasto"),
                                      content: Text(
                                        "¿Está seguro de eliminar este gasto?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancelar"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<GastosCubits>()
                                                .dellGasto(state[index].id);
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
                },
              );
            }
          },
        ),
      ),
    );
  }
}
