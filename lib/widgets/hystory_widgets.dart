import 'package:bills_control/l10n/app_localizations.dart'
    show AppLocalizations;
import 'package:bills_control/widgets/category_selector.dart';
import 'package:flutter/material.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:bills_control/cubits/cubits_all.dart';
import 'package:intl/intl.dart';

// Define el formato exacto que tiene tu String
DateFormat format = DateFormat("yyyy/M/d");

TextEditingController categoryController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController descriptionController = TextEditingController();
TextEditingController dateController = TextEditingController();

Future<void> editGastoItem(
  BuildContext context,
  int index,
  List<GastosItem> stateFilter,
  GastosHistorialCubits ghisto,
  GastosCubits gasto,
) async {
  categoryController.text = stateFilter[index].category;
  amountController.text = stateFilter[index].amount.toString();
  descriptionController.text = stateFilter[index].description;
  final date = stateFilter[index].date;
  dateController.text = '${date.year}/${date.month}/${date.day}';
  final idBills = stateFilter[index].gastoId;
  return showDialog(
    context: context,
    builder: (context) {
      final currentAmount = stateFilter[index].amount;
      return AlertDialog(
        title: Center(
          child: Text(AppLocalizations.of(context)!.texto_editar_gasto),
        ),
        content: SizedBox(
          height: 33.h,
          width: 80.w,
          child: Column(
            children: [
              TextField(
                controller: descriptionController,
                maxLength: 30,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.etiqueta_motivo,
                ),
              ),
              CategorySelector(controller: categoryController),
              TextField(
                keyboardType: TextInputType.number,
                controller: dateController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.etiqueta_fecha,
                ),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.etiqueta_monto,
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(backgroundColor: Colors.black26),
                child: Text(
                  AppLocalizations.of(context)!.etiqueta_cancelar,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (double.parse(amountController.text) != currentAmount) {
                    await sumarGasto(idBills, currentAmount);
                    if (context.mounted) {
                      gasto.sumGasto(idBills, currentAmount);
                    }
                    await restarGasto(
                      idBills,
                      double.parse(amountController.text),
                    );
                  }
                  if (context.mounted) {
                    DateTime temp = format.parse(dateController.text);
                    ghisto.updGastoItem(
                      stateFilter[index].id,
                      idBills,
                      descriptionController.text,
                      double.parse(amountController.text),
                      temp,
                      categoryController.text,
                      '',
                    );
                    stateFilter = [];
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(backgroundColor: Colors.black26),
                child: Text(
                  AppLocalizations.of(context)!.etiqueta_actualizar,
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}

Future<void> deleteGastoItem(
  BuildContext context,
  int idBills,
  int id,
  int index,
  List<GastosItem> stateFilter,
  GastosHistorialCubits ghisto,
  GastosCubits gasto,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Text(AppLocalizations.of(context)!.texto_eliminar_gasto),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.texto_eliminar_gasto_confirmacion,
            ),
            Text(
              stateFilter[index].description,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(backgroundColor: Colors.black26),
                child: Text(
                  AppLocalizations.of(context)!.etiqueta_cancelar,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () async {
                  gasto.sumGasto(
                    stateFilter[index].gastoId,
                    stateFilter[index].amount,
                  );
                  ghisto.dellGastoItem(stateFilter[index].id);
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(backgroundColor: Colors.black26),
                child: Text(
                  AppLocalizations.of(context)!.toolTip_delete,
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
