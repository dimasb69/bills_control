import 'dart:convert';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../screens/excel_preview_screen.dart';

Future<void> convertDataToExcel(int billId, BuildContext mainContext) async {
  showDialog(
    context: mainContext,
    builder: (mainContext) {
      return const Center(child: CircularProgressIndicator());
    },
  );
  
  var excel = Excel.createExcel();
  final l10n = AppLocalizations.of(mainContext)!;

  final gastos = await readGastoById(billId);
  if (gastos.isEmpty) {
    if (mainContext.mounted) Navigator.pop(mainContext);
    return;
  }

  final gastosItems = await readAllGastosItems();
  final closedHistory = await readHistoryCerradoByGastoId(billId);

  // Helper to add header with L10n
  void addHeader(Sheet sheet) {
    sheet.appendRow([
      TextCellValue(l10n.etiqueta_fecha),
      TextCellValue(l10n.etiueta_descripcion),
      TextCellValue(l10n.texto_categoria),
      TextCellValue(l10n.excel_header_monto_gastado),
    ]);
  }

  // 1. Current Items
  String firstSheetName = excel.tables.keys.first;
  Sheet sheetActual = excel[firstSheetName];
  excel.rename(firstSheetName, 'Actual');
  addHeader(sheetActual);
  
  for (var item in gastosItems) {
    if (item.gastoId == billId) {
      sheetActual.appendRow([
        TextCellValue('${item.date.day}/${item.date.month}/${item.date.year}'),
        TextCellValue(item.description),
        TextCellValue(item.category),
        TextCellValue(item.amount.toString()),
      ]);
    }
  }

  // 2. Archived Items
  for (var entry in closedHistory) {
    try {
      final file = File(entry.jsonPath);
      if (await file.exists()) {
        final content = await file.readAsString();
        final List<dynamic> jsonItems = jsonDecode(content);
        if (jsonItems.isNotEmpty) {
          Sheet periodSheet = excel[entry.periodLabel];
          addHeader(periodSheet);
          for (var item in jsonItems) {
            final date = DateTime.parse(item['date']);
            periodSheet.appendRow([
              TextCellValue('${date.day}/${date.month}/${date.year}'),
              TextCellValue(item['description'] ?? ''),
              TextCellValue(item['category'] ?? ''),
              TextCellValue(item['amount']?.toString() ?? '0'),
            ]);
          }
        }
      }
    } catch (e) {
      // Skip
    }
  }

  var fileBytes = excel.save();
  var directory = await getApplicationDocumentsDirectory(); // Use Documents for persistent preview
  var fileName = "${directory.path}/${gastos.first.motivo}.xlsx";

  var file = File(fileName);
  if (file.existsSync()) {
    file.deleteSync();
  }
  file.createSync(recursive: true);
  file.writeAsBytesSync(fileBytes!);

  if (mainContext.mounted) {
    Navigator.pop(mainContext); // Close progress dialog
    
    // Navigate to Preview Screen
    Navigator.push(
      mainContext,
      MaterialPageRoute(
        builder: (context) => ExcelPreviewScreen(
          bytes: fileBytes,
          filePath: file.path,
          title: gastos.first.motivo,
        ),
      ),
    );
  }
}
