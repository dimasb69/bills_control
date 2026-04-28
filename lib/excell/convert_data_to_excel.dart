import 'dart:convert';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../screens/excel_preview_screen.dart';

const List<String> _monthNames = [
  'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
  'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
];

/// Export the CURRENT active period for a budget.
/// - Monthly: current month items + all closed months of the SAME year
/// - Annual: current year items grouped by month + Resumen sheet
Future<void> convertDataToExcel(int billId, BuildContext mainContext) async {
  showDialog(
    context: mainContext,
    builder: (mainContext) {
      return const Center(child: CircularProgressIndicator());
    },
  );

  final l10n = AppLocalizations.of(mainContext)!;
  final gastos = await readGastoById(billId);
  if (gastos.isEmpty) {
    if (mainContext.mounted) Navigator.pop(mainContext);
    return;
  }

  final budget = gastos.first;
  final gastosItems = await readAllGastosItems();
  final currentItems = gastosItems.where((i) => i.gastoId == billId).toList();
  final closedHistory = await readHistoryCerradoByGastoId(billId);
  final now = DateTime.now();

  var excel = Excel.createExcel();
  final String firstSheetName = excel.tables.keys.first;

  void addHeader(Sheet sheet) {
    sheet.appendRow([
      TextCellValue(l10n.etiqueta_fecha),
      TextCellValue(l10n.etiueta_descripcion),
      TextCellValue(l10n.texto_categoria),
      TextCellValue(l10n.excel_header_monto_gastado),
    ]);
  }

  if (budget.type == 'annual') {
    // ── ANNUAL EXPORT ──────────────────────────────────────────────────────
    // Group current year items by month, one sheet per month + Resumen
    excel.rename(firstSheetName, 'Resumen');
    Sheet resumenSheet = excel['Resumen'];
    resumenSheet.appendRow([
      TextCellValue('Mes'),
      TextCellValue('Gastos'),
      TextCellValue('Total Gastado'),
    ]);

    // Map: month index (1-12) -> items
    Map<int, List<GastosItem>> byMonth = {};
    for (var item in currentItems) {
      final m = item.date.month;
      byMonth.putIfAbsent(m, () => []).add(item);
    }

    double grandTotal = 0;
    for (int m = 1; m <= 12; m++) {
      final items = byMonth[m] ?? [];
      if (items.isEmpty) continue;
      final monthName = _monthNames[m - 1];
      Sheet mSheet = excel[monthName];
      addHeader(mSheet);
      double monthTotal = 0;
      for (var item in items) {
        mSheet.appendRow([
          TextCellValue('${item.date.day}/${item.date.month}/${item.date.year}'),
          TextCellValue(item.description),
          TextCellValue(item.category),
          TextCellValue(item.amount.toString()),
        ]);
        monthTotal += item.amount;
      }
      grandTotal += monthTotal;
      resumenSheet.appendRow([
        TextCellValue(monthName),
        TextCellValue(items.length.toString()),
        TextCellValue(monthTotal.toStringAsFixed(2)),
      ]);
    }
    // Grand total row
    resumenSheet.appendRow([
      TextCellValue('TOTAL'),
      TextCellValue(''),
      TextCellValue(grandTotal.toStringAsFixed(2)),
    ]);

  } else {
    // ── MONTHLY EXPORT ──────────────────────────────────────────────────────
    // Current month items in first sheet
    excel.rename(firstSheetName, 'Actual');
    Sheet sheetActual = excel['Actual'];
    addHeader(sheetActual);
    for (var item in currentItems) {
      sheetActual.appendRow([
        TextCellValue('${item.date.day}/${item.date.month}/${item.date.year}'),
        TextCellValue(item.description),
        TextCellValue(item.category),
        TextCellValue(item.amount.toString()),
      ]);
    }

    // Closed months of the SAME year only (filter by year in periodLabel)
    final currentYearStr = now.year.toString();
    final sameYearEntries = closedHistory.where(
      (e) => e.periodType == 'monthly' && e.periodLabel.contains(currentYearStr),
    ).toList();

    for (var entry in sameYearEntries) {
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
        // Skip unreadable entries
      }
    }
  }

  await _saveAndPreview(excel, budget.motivo, mainContext);
}

/// Export a single archived period (monthly or annual) from its JSON file.
Future<void> exportArchivedPeriod(
  GastosHistorialCerradoData entry,
  String budgetName,
  BuildContext mainContext,
) async {
  showDialog(
    context: mainContext,
    builder: (_) => const Center(child: CircularProgressIndicator()),
  );

  final l10n = AppLocalizations.of(mainContext)!;
  final file = File(entry.jsonPath);

  if (!await file.exists()) {
    if (mainContext.mounted) {
      Navigator.pop(mainContext);
      ScaffoldMessenger.of(mainContext).showSnackBar(
        SnackBar(content: Text(l10n.no_data_to_export)),
      );
    }
    return;
  }

  final content = await file.readAsString();
  final List<dynamic> jsonItems = jsonDecode(content);

  var excel = Excel.createExcel();
  final String firstSheetName = excel.tables.keys.first;

  void addHeader(Sheet sheet) {
    sheet.appendRow([
      TextCellValue(l10n.etiqueta_fecha),
      TextCellValue(l10n.etiueta_descripcion),
      TextCellValue(l10n.texto_categoria),
      TextCellValue(l10n.excel_header_monto_gastado),
    ]);
  }

  if (entry.periodType == 'annual') {
    // Annual archived period: group by month
    excel.rename(firstSheetName, 'Resumen');
    Sheet resumenSheet = excel['Resumen'];
    resumenSheet.appendRow([
      TextCellValue('Mes'),
      TextCellValue('Gastos'),
      TextCellValue('Total Gastado'),
    ]);

    Map<int, List<dynamic>> byMonth = {};
    for (var item in jsonItems) {
      final date = DateTime.parse(item['date']);
      byMonth.putIfAbsent(date.month, () => []).add(item);
    }

    double grandTotal = 0;
    for (int m = 1; m <= 12; m++) {
      final items = byMonth[m] ?? [];
      if (items.isEmpty) continue;
      final monthName = _monthNames[m - 1];
      Sheet mSheet = excel[monthName];
      addHeader(mSheet);
      double monthTotal = 0;
      for (var item in items) {
        final date = DateTime.parse(item['date']);
        mSheet.appendRow([
          TextCellValue('${date.day}/${date.month}/${date.year}'),
          TextCellValue(item['description'] ?? ''),
          TextCellValue(item['category'] ?? ''),
          TextCellValue(item['amount']?.toString() ?? '0'),
        ]);
        monthTotal += (item['amount'] ?? 0).toDouble();
      }
      grandTotal += monthTotal;
      resumenSheet.appendRow([
        TextCellValue(monthName),
        TextCellValue(items.length.toString()),
        TextCellValue(monthTotal.toStringAsFixed(2)),
      ]);
    }
    resumenSheet.appendRow([
      TextCellValue('TOTAL'),
      TextCellValue(''),
      TextCellValue(grandTotal.toStringAsFixed(2)),
    ]);
  } else {
    // Monthly archived period: single sheet
    excel.rename(firstSheetName, entry.periodLabel);
    Sheet sheet = excel[entry.periodLabel];
    addHeader(sheet);
    for (var item in jsonItems) {
      final date = DateTime.parse(item['date']);
      sheet.appendRow([
        TextCellValue('${date.day}/${date.month}/${date.year}'),
        TextCellValue(item['description'] ?? ''),
        TextCellValue(item['category'] ?? ''),
        TextCellValue(item['amount']?.toString() ?? '0'),
      ]);
    }
  }

  final exportName = '$budgetName - ${entry.periodLabel}';
  await _saveAndPreview(excel, exportName, mainContext);
}

Future<void> _saveAndPreview(
  Excel excel,
  String name,
  BuildContext mainContext,
) async {
  final fileBytes = excel.save();
  final directory = await getApplicationDocumentsDirectory();
  final safeName = name.replaceAll(RegExp(r'[^\w\s\-]'), '').trim();
  final fileName = '${directory.path}/$safeName.xlsx';
  final file = File(fileName);
  if (file.existsSync()) file.deleteSync();
  file.createSync(recursive: true);
  file.writeAsBytesSync(fileBytes!);

  if (mainContext.mounted) {
    Navigator.pop(mainContext); // Close progress dialog
    Navigator.push(
      mainContext,
      MaterialPageRoute(
        builder: (context) => ExcelPreviewScreen(
          bytes: fileBytes,
          filePath: file.path,
          title: name,
        ),
      ),
    );
  }
}
