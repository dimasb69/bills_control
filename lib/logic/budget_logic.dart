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
        // Reset when the month has changed
        if (now.year > lastReset.year ||
            (now.year == lastReset.year && now.month > lastReset.month)) {
          shouldReset = true;
        }
      } else if (budget.type == 'annual') {
        // Annual only resets when the YEAR changes (not the month)
        if (now.year > lastReset.year) {
          shouldReset = true;
        }
      }

      if (shouldReset) {
        if (budget.type == 'monthly') {
          await _closeMonthlyPeriod(budget, lastReset);
        } else if (budget.type == 'annual') {
          await _closeAnnualPeriod(budget, lastReset);
        }
      }
    }
  }

  /// Manual close for monthly budgets (user-triggered)
  static Future<void> manualCloseMonthlyPeriod(Gasto budget) async {
    final now = DateTime.now();
    await _closeMonthlyPeriod(budget, now);
    // Set lastResetDate to the start of the next month
    DateTime nextMonth;
    if (now.month == 12) {
      nextMonth = DateTime(now.year + 1, 1, 1);
    } else {
      nextMonth = DateTime(now.year, now.month + 1, 1);
    }
    await resetGastoPeriod(budget.id, budget.initialAmount, nextMonth);
  }

  /// Manual close for annual budgets (user-triggered)
  static Future<void> manualCloseAnnualPeriod(Gasto budget) async {
    final now = DateTime.now();
    await _closeAnnualPeriod(budget, now);
    // Set lastResetDate to Jan 1 of next year
    final nextYear = DateTime(now.year + 1, 1, 1);
    await resetGastoPeriod(budget.id, budget.initialAmount, nextYear);
  }

  /// Close a monthly period: archives items to JSON, records in DB, resets budget
  static Future<void> _closeMonthlyPeriod(Gasto budget, DateTime periodDate) async {
    final allItems = await readAllGastosItems();
    final budgetItems = allItems.where((item) => item.gastoId == budget.id).toList();

    final jsonData = budgetItems.map((item) => {
      'description': item.description,
      'date': item.date.toIso8601String(),
      'amount': item.amount,
      'category': item.category,
      'type': item.type,
    }).toList();

    final directory = await getApplicationSupportDirectory();
    final periodLabel = _getMonthlyPeriodName(periodDate);
    final safeLabel = '${periodDate.month}_${periodDate.year}';
    final fileName = 'history_${budget.id}_$safeLabel.json';
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(jsonEncode(jsonData));

    double totalSpent = budgetItems.fold(0, (sum, item) => sum + item.amount);

    await writeHistoryCerrado(
      budget.id,
      periodLabel,
      file.path,
      totalSpent,
      periodType: 'monthly',
    );

    // Reset budget to initial amount, update lastResetDate
    await resetGastoPeriod(budget.id, budget.initialAmount, DateTime.now());
  }

  /// Close an annual period: archives all items to JSON, records in DB, resets budget
  static Future<void> _closeAnnualPeriod(Gasto budget, DateTime periodDate) async {
    final allItems = await readAllGastosItems();
    final budgetItems = allItems.where((item) => item.gastoId == budget.id).toList();

    final jsonData = budgetItems.map((item) => {
      'description': item.description,
      'date': item.date.toIso8601String(),
      'amount': item.amount,
      'category': item.category,
      'type': item.type,
    }).toList();

    final directory = await getApplicationSupportDirectory();
    // Annual label is just the year number
    final yearLabel = '${periodDate.year}';
    final fileName = 'history_annual_${budget.id}_$yearLabel.json';
    final file = File('${directory.path}/$fileName');
    await file.writeAsString(jsonEncode(jsonData));

    double totalSpent = budgetItems.fold(0, (sum, item) => sum + item.amount);

    await writeHistoryCerrado(
      budget.id,
      yearLabel,
      file.path,
      totalSpent,
      periodType: 'annual',
    );

    // Reset budget and set lastResetDate to Jan 1 of next year
    final nextYear = DateTime(periodDate.year + 1, 1, 1);
    await resetGastoPeriod(budget.id, budget.initialAmount, nextYear);
  }

  static String _getMonthlyPeriodName(DateTime date) {
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
