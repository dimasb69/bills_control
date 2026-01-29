import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:bills_control/screens/gastos_historial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/widgets/category_selector.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

// Define el formato exacto que tiene tu String
DateFormat format = DateFormat("yyyy/M/d");

List<Gasto> gastosList = [];
TextEditingController descriptionController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController categoryController = TextEditingController();
TextEditingController dateController = TextEditingController();

class GastosHistorialAdd extends StatelessWidget {
  const GastosHistorialAdd({super.key, required this.id, required this.name});

  final int id;
  final String name;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    dateController.text = '${now.year}/${now.month}/${now.day}';
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            dateController.clear();
            descriptionController.clear();
            categoryController.clear();
            amountController.clear();
            Navigator.pop(context);
          },
        ),
        title: Text("Nuevo movimiento $name"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            top: 30.dp,
            left: 10.dp,
            right: 10.dp,
          ),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: descriptionController,
                  maxLength: 30,
                  decoration: const InputDecoration(
                    labelText: "Descripcion",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                CategorySelector(controller: categoryController),
                SizedBox(height: 5.h),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: "Monto a descontar",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "Fecha de inicio",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          dateController.clear();
                          descriptionController.clear();
                          categoryController.clear();
                          amountController.clear();
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black26,
                        ),
                        child: const Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (categoryController.text.length < 4 &&
                              descriptionController.text.length < 4 &&
                              categoryController.text.length < 4 &&
                              categoryController.text.isEmpty &&
                              descriptionController.text.isEmpty &&
                              amountController.text.isEmpty &&
                              dateController.text.isEmpty &&
                              amountController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Revise los campos que esten vacios o con menos de 4 caracteres",
                                ),
                              ),
                            );
                            return;
                          }
                          DateTime temp = format.parse(dateController.text);
                          await writeGastoItem(
                            id,
                            descriptionController.text,
                            temp,
                            double.parse(amountController.text),
                            categoryController.text,
                            '',
                          ).whenComplete(() async {
                            if (context.mounted) {
                              context.read<GastosCubits>().resGasto(
                                id,
                                double.parse(amountController.text),
                              );
                            }

                            dateController.clear();
                            descriptionController.clear();
                            categoryController.clear();
                            amountController.clear();
                            if (context.mounted) {
                              stateFilter = [];
                              context
                                  .read<GastosHistorialCubits>()
                                  .getGastosItems();
                              Navigator.pop(context);
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black26,
                        ),
                        child: const Text(
                          "Guardar",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
