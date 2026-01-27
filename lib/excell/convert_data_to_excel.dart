import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';

Future<void> convertDataToExcel(int billId, BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
  var excel = Excel.createExcel();

  final gastos = await readGastoById(billId);
  final gastosItems = await readAllGastosItems();

  Sheet sheetObject = excel[gastos.first.motivo];

  // Añadir cabecera
  sheetObject.appendRow([
    TextCellValue('Fecha'),
    TextCellValue('Descripción'),
    TextCellValue('Categoria'),
    TextCellValue('Importe'),
  ]);

  for (var gastoItem in gastosItems) {
    if (gastoItem.gastoId == billId) {
      sheetObject.appendRow([
        TextCellValue(gastoItem.date.toString()),
        TextCellValue(gastoItem.description),
        TextCellValue(gastoItem.category),
        TextCellValue(gastoItem.amount.toString()),
      ]);
    }
  }

  var fileBytes = excel.save();
  var directory = await getApplicationDocumentsDirectory();
  File("${directory.path}/${gastos.first.motivo}.xlsx")
    ..createSync(recursive: true)
    ..writeAsBytesSync(fileBytes!);

  OpenFile.open("${directory.path}/${gastos.first.motivo}.xlsx");

  print("${directory.path}/${gastos.first.motivo}.xlsx");
  if (context.mounted) {
    Navigator.pop(context);
  }
}
