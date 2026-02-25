import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

Future<void> convertDataToExcel(int billId, BuildContext mainContext) async {
  showDialog(
    context: mainContext,
    builder: (mainContext) {
      return const Center(child: CircularProgressIndicator());
    },
  );
  var excel = Excel.createExcel();

  final gastos = await readGastoById(billId);
  final gastosItems = await readAllGastosItems();

  Sheet sheetObject = excel['Sheet1'];

  // Añadir cabecera
  if (mainContext.mounted) {
    sheetObject.appendRow([
      TextCellValue(AppLocalizations.of(mainContext)!.etiqueta_fecha),
      TextCellValue(AppLocalizations.of(mainContext)!.etiueta_descripcion),
      TextCellValue(AppLocalizations.of(mainContext)!.texto_categoria),
      TextCellValue(AppLocalizations.of(mainContext)!.etiqueta_monto),
    ]);
  }

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
      if (mainContext.mounted) {
        Navigator.pop(mainContext);
        if (value.type == ResultType.done) {
          ScaffoldMessenger.of(mainContext).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(mainContext)!.snack_text_abierto,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(mainContext).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(mainContext)!.snack_text_error),
            ),
          );
        }
      }
    });
  } catch (e) {
    if (mainContext.mounted) {
      Navigator.pop(mainContext);
      ScaffoldMessenger.of(mainContext).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(mainContext)!.snack_text_error),
        ),
      );
    }
  }
}
