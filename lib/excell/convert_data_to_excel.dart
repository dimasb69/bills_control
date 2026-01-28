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

  Sheet sheetObject = excel['Sheet1'];

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
        TextCellValue(
          '${gastoItem.date.day}/${gastoItem.date.month}/${gastoItem.date.year}',
        ),
        TextCellValue(gastoItem.description),
        TextCellValue(gastoItem.category),
        TextCellValue(gastoItem.amount.toString()),
      ]);
    }
  }

  var fileBytes = excel.save();
  var directory = await getDownloadsDirectory();
  var fileName = "${directory?.path}/${gastos.first.motivo}.xlsx";

  var file = File(fileName);
  if (file.existsSync()) {
    file.deleteSync();
  }
  file.createSync(recursive: true);
  file.writeAsBytesSync(fileBytes!);

  try {
    await OpenFile.open(file.path).then((value) {
      if (context.mounted) {
        Navigator.pop(context);
        if (value.type == ResultType.done) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Archivo abierto")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error al abrir, Visor de Excel no instalado"),
            ),
          );
        }
      }
    });
  } catch (e) {
    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error al abrir el archivo")));
    }
  }
}
