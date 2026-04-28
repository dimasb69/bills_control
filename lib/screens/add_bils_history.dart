import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:bills_control/l10n/app_localizations.dart';
import 'package:bills_control/screens/gastos_historial.dart';
import 'package:bills_control/widgets/dev_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/widgets/category_selector.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

// Define el formato exacto que tiene tu String
DateFormat format = DateFormat("yyyy/M/d");

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
    final budget = context.read<GastosCubits>().state.firstWhere((e) => e.id == id);
    DateTime defaultDate = DateTime.now();
    bool isFuturePeriod = false;

    if (budget.lastResetDate != null && budget.lastResetDate!.isAfter(defaultDate)) {
      defaultDate = budget.lastResetDate!;
      isFuturePeriod = true;
    }

    dateController.text = '${defaultDate.year}/${defaultDate.month}/${defaultDate.day}';
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
        title: Text(
          name.length > 14
              ? "${AppLocalizations.of(context)!.tittle_add_new_history} ${name.substring(0, 14)}..."
              : "${AppLocalizations.of(context)!.tittle_add_new_history} $name",
          style: TextStyle(fontSize: 14.dp),
        ),
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
                if (isFuturePeriod)
                  Container(
                    margin: EdgeInsets.only(bottom: 20.dp),
                    padding: EdgeInsets.all(10.dp),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.dp),
                      border: Border.all(color: Colors.orangeAccent),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orangeAccent),
                        SizedBox(width: 10.dp),
                        Expanded(
                          child: Text(
                            "Este periodo ya fue cerrado. El gasto se registrará automáticamente para el próximo mes (${defaultDate.day}/${defaultDate.month}/${defaultDate.year}).",
                            style: TextStyle(fontSize: 12.dp, color: Colors.orangeAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                TextField(
                  controller: descriptionController,
                  maxLength: 30,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.etiueta_descripcion,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                CategorySelector(controller: categoryController),
                SizedBox(height: 5.h),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.etiqueta_monto_descuento,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(
                      context,
                    )!.etiqueta_fecha_inicio,
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
                        child: Text(
                          AppLocalizations.of(context)!.etiqueta_cancelar,
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
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.snack_text_caracteres_vacio,
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
                        child: Text(
                          AppLocalizations.of(context)!.etiqueta_guardar,
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
