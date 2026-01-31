import 'package:bills_control/cubits/gastos_cubits.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:bills_control/widgets/dev_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

// Define el formato exacto que tiene tu String
DateFormat format = DateFormat("yyyy/M/d");

List<Gasto> gastosList = [];
TextEditingController motivoController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController newAmountController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController idUpdateController = TextEditingController();

class NewControl extends StatelessWidget {
  const NewControl({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    dateController.text = '${now.year}/${now.month}/${now.day}';
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            dateController.clear();
            motivoController.clear();
            amountController.clear();
            Navigator.pop(context);
          },
        ),
        title: const Text("Nuevo Presupuesto"),
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
                  controller: motivoController,
                  maxLength: 22,
                  decoration: const InputDecoration(
                    labelText: "Motivo / Concepto",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: "Monto a manejar",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "Fecha",
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
                          motivoController.clear();
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
                          if (motivoController.text.length < 4) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "El motivo debe tener al menos 4 caracteres",
                                ),
                              ),
                            );
                            return;
                          }
                          await writeGasto(
                            motivoController.text,
                            format.parse(dateController.text),
                            double.parse(amountController.text),
                          ).whenComplete(() async {
                            dateController.clear();
                            motivoController.clear();
                            amountController.clear();
                            if (context.mounted) {
                              context.read<GastosCubits>().getGastos();
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
      bottomNavigationBar: bottomDevName(),
    );
  }
}
