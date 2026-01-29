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
        title: Center(child: Text("Editar gasto")),
        content: SizedBox(
          height: 33.h,
          width: 80.w,
          child: Column(
            children: [
              TextField(
                controller: descriptionController,
                maxLength: 30,
                decoration: const InputDecoration(labelText: "Concepto"),
              ),
              CategorySelector(controller: categoryController),
              TextField(
                keyboardType: TextInputType.number,
                controller: dateController,
                decoration: const InputDecoration(labelText: "Fecha"),
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountController,
                decoration: const InputDecoration(labelText: "Monto"),
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
                child: const Text(
                  "Cancelar",
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
                child: const Text(
                  "Actualizar",
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
        title: Center(child: Text("Eliminar movimiento")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("¿Está seguro de eliminar este movimiento?"),
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
                child: const Text(
                  "Cancelar",
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
                child: const Text(
                  "Eliminar",
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
