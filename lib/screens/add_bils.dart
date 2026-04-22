import 'package:bills_control/cubits/gastos_cubits.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:bills_control/l10n/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context)!.tittle_add_new),
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
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.etiqueta_motivo,
                    hintText: AppLocalizations.of(context)!.hint_motivo,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.etiqueta_monto,
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 5.h),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.etiqueta_fecha,
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
                        child: Text(
                          AppLocalizations.of(context)!.etiqueta_cancelar,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (motivoController.text.length < 4) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.snack_text_caracteres_minimos,
                                ),
                              ),
                            );
                            return;
                          }
                          if (double.parse(amountController.text) <= 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!.snack_text_monto_minimo,
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
