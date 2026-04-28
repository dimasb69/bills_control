import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';

class BudgetLogic {
  static Future<void> checkAndResetBudgets() async {
    final allBudgets = await readAllGastos();
    final now = DateTime.now();

    for (var budget in allBudgets) {
      if (budget.type == 'normal') continue;

      final lastReset = budget.lastResetDate ?? budget.date;
      bool shouldReset = false;

      if (budget.type == 'monthly') {
        if (now.year > lastReset.year || (now.year == lastReset.year && now.month > lastReset.month)) {
          shouldReset = true;
        }
      } else if (budget.type == 'annual') {
        // According to user request: "al terminar el mes tome solo los gastos... y cree el nuevo mes"
        // This implies even Annual archives monthly.
        if (now.year > lastReset.year || (now.year == lastReset.year && now.month > lastReset.month)) {
          shouldReset = true;
        }
      }

      if (shouldReset) {
        await closePeriod(budget, lastReset);
      }
    }
  }

  static Future<void> manualClosePeriod(Gasto budget) async {
    final now = DateTime.now();
    // Calculate the start of the next month
    DateTime nextPeriod;
    if (now.month == 12) {
      nextPeriod = DateTime(now.year + 1, 1, 1);
    } else {
      nextPeriod = DateTime(now.year, now.month + 1, 1);
    }
    
    await closePeriod(budget, now);
    // Update the lastResetDate to the future period start
    await resetGastoPeriod(budget.id, budget.initialAmount, nextPeriod);
  }

  static Future<void> closePeriod(Gasto budget, DateTime periodDate) async {
    // 1. Get items for this budget
    final allItems = await readAllGastosItems();
    final budgetItems = allItems.where((item) => item.gastoId == budget.id).toList();

    // Prepare JSON data (even if empty, to record the period closure)
    final jsonData = budgetItems.map((item) => {
      'description': item.description,
      'date': item.date.toIso8601String(),
      'amount': item.amount,
      'category': item.category,
      'type': item.type,
    }).toList();

    // 2. Save to File
    final directory = await getApplicationSupportDirectory();
    // Use periodDate for the label (e.g. if we close on April 27, it's the "Abril" period)
    final periodLabel = "${periodDate.month}_${periodDate.year}";
    final fileName = "history_${budget.id}_$periodLabel.json";
    final file = File("${directory.path}/$fileName");
    
    await file.writeAsString(jsonEncode(jsonData));

    // 3. Calculate total spent in this period
    double totalSpent = budgetItems.fold(0, (sum, item) => sum + item.amount);

    // 4. Update Database (Record the closed period)
    await writeHistoryCerrado(
      budget.id,
      _getPeriodName(periodDate),
      file.path,
      totalSpent,
    );

    // 5. Reset Budget
    // Default reset to now, unless overridden by manualClosePeriod
    await resetGastoPeriod(budget.id, budget.initialAmount, DateTime.now());
  }

  static String _getPeriodName(DateTime date) {
    final months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    // Check if the date is actually in the future (next period)
    // but the closure refers to the current one.
    // However, usually _getPeriodName is called with the date of the period being CLOSED.
    return "${months[date.month - 1]} ${date.year}";
  }
}
