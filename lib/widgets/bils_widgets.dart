import 'package:bills_control/cubits/cubits_all.dart';
import 'package:bills_control/l10n/app_localizations.dart'
    show AppLocalizations;
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
        title: Center(
          child: Text(AppLocalizations.of(context)!.texto_editar_presupuesto),
        ),
        content: SizedBox(
          height: 18.h,
          width: 80.w,
          child: Column(
            children: [
              TextField(
                controller: motivoController,
                maxLength: 22,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.etiqueta_motivo,
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
            children: [
              Text(AppLocalizations.of(context)!.toolTip_agregar_saldo),
              Text(state[index].motivo),
            ],
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
                child: Text(
                  AppLocalizations.of(context)!.etiqueta_guardar,
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
        title: Center(
          child: Text(AppLocalizations.of(context)!.texto_eliminar_presupuesto),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalizations.of(
                context,
              )!.texto_eliminar_presupuesto_confirmacion,
            ),
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
                child: Text(
                  AppLocalizations.of(context)!.etiqueta_cancelar,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  gCubit.dellGasto(state[index].id);
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
