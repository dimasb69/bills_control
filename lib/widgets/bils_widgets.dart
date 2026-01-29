import 'package:bills_control/cubits/cubits_all.dart';
import 'package:flutter/material.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

TextEditingController motivoController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController newAmountController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController idUpdateController = TextEditingController();

Future<void> editGasto(
  List<Gasto> state,
  int index,
  BuildContext context,
  GastosCubits gCubit,
) async {
  idUpdateController.text = state[index].id.toString();
  motivoController.text = state[index].motivo;
  amountController.text = state[index].amount.toString();
  final fecha = state[index].date;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(child: Text("Editar gasto")),
        content: SizedBox(
          height: 18.h,
          width: 80.w,
          child: Column(
            children: [
              TextField(
                controller: motivoController,
                maxLength: 22,
                decoration: const InputDecoration(labelText: "Motivo"),
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
                onPressed: () {
                  gCubit.updGasto(
                    int.parse(idUpdateController.text),
                    motivoController.text,
                    double.parse(amountController.text),
                    fecha,
                  );
                  Navigator.pop(context);
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

Future<void> agregarSaldo(
  List<Gasto> state,
  int index,
  BuildContext context,
  GastosCubits gCubit,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(
          child: Column(
            children: [Text("Agregar saldo"), Text(state[index].motivo)],
          ),
        ),
        content: SizedBox(
          height: 10.h,
          width: 80.w,
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.number,
                controller: newAmountController,
                decoration: const InputDecoration(labelText: "Monto"),
              ),
            ],
          ),
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
                  if (context.mounted) {
                    gCubit.sumGasto(
                      state[index].id,
                      double.parse(newAmountController.text),
                    );
                    newAmountController.clear();
                    Navigator.pop(context);
                  }
                },
                style: TextButton.styleFrom(backgroundColor: Colors.black26),
                child: const Text(
                  "Agregar",
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

Future<void> deleteGasto(
  List<Gasto> state,
  int index,
  BuildContext context,
  GastosCubits gCubit,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Center(child: Text("Eliminar gasto")),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("¿Está seguro de eliminar este gasto?"),
            Text(state[index].motivo),
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
                onPressed: () {
                  gCubit.dellGasto(state[index].id);
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
