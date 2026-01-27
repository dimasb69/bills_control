import 'package:bills_control/cubits/gastos_cubits.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

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
    DateTime date = DateTime(now.year, now.month, now.day);
    dateController.text = date.toString();
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
        title: const Text("Nuevo Control"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: motivoController,
                  decoration: const InputDecoration(
                    labelText: "Motivo / Concepto",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(
                    labelText: "Monto a manejar",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: "Fecha de inicio",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
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
                            DateTime.parse(dateController.text),
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
                        child: const Text("Guardar"),
                      ),
                      SizedBox(width: 15.w),
                      ElevatedButton(
                        onPressed: () {
                          dateController.clear();
                          motivoController.clear();
                          amountController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text("Cancelar"),
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
