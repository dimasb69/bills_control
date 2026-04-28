import 'dart:io';
import 'package:bills_control/data_base/gastos.dart';
import 'package:drift/drift.dart';

final gastosDatabase = GastosDatabase();

//Tabla Gastos
Future<List<Gasto>> readAllGastos() async {
  List<Gasto> allGastos = await gastosDatabase
      .select(gastosDatabase.gastos)
      .get();
  return allGastos;
}

Future<void> writeGasto(String motivo, DateTime date, double amount, {String type = 'normal'}) async {
  await gastosDatabase
      .into(gastosDatabase.gastos)
      .insert(
        GastosCompanion.insert(
          motivo: motivo, 
          date: date, 
          amount: amount,
          initialAmount: Value(amount),
          type: Value(type),
          lastResetDate: Value(DateTime.now()),
        ),
      );
}

Future<List<Gasto>> readGastoById(int id) async {
  List<Gasto> gasto = await (gastosDatabase.select(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).get();
  return gasto;
}

Future<void> deleteGasto(int id) async {
  // Get all closed history entries for this budget to delete physical files
  final closedHistory = await (gastosDatabase.select(gastosDatabase.gastosHistorialCerrado)
    ..where((t) => t.gastoId.equals(id))).get();
  
  for (var entry in closedHistory) {
    try {
      final file = File(entry.jsonPath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Ignore errors if file doesn't exist or can't be deleted
    }
  }

  await gastosDatabase.transaction(() async {
    await (gastosDatabase.delete(gastosDatabase.gastos)
          ..where((t) => t.id.equals(id)))
        .go();
  });
}

//Tabla Categorias
Future<List<Categoria>> readAllCategorias() async {
  return await gastosDatabase.select(gastosDatabase.categorias).get();
}

Future<void> writeCategoria(String name) async {
  await gastosDatabase.into(gastosDatabase.categorias).insert(
        CategoriasCompanion.insert(name: name),
      );
}

Future<void> deleteCategoria(int id) async {
  await (gastosDatabase.delete(gastosDatabase.categorias)
        ..where((t) => t.id.equals(id)))
      .go();
}

//Tabla Settings
Future<AppSetting?> readSettings() async {
  return await gastosDatabase.select(gastosDatabase.appSettings).getSingleOrNull();
}

Future<void> updateSettings(bool showAutoHelp) async {
  final settings = await readSettings();
  if (settings == null) {
    await gastosDatabase.into(gastosDatabase.appSettings).insert(
          AppSettingsCompanion.insert(showAutoHelp: Value(showAutoHelp)),
        );
  } else {
    await (gastosDatabase.update(gastosDatabase.appSettings)
          ..where((t) => t.id.equals(settings.id)))
        .write(AppSettingsCompanion(showAutoHelp: Value(showAutoHelp)));
  }
}

Future updateGasto(int id, String motivo, double newAmount) async {
  // If user manually updates the current amount, we should probably adjust initialAmount too
  // Or at least ensure it's not smaller than the current amount.
  // Let's just update both for simplicity in this case.
  return (gastosDatabase.update(gastosDatabase.gastos)
        ..where((t) => t.id.equals(id)))
      .write(GastosCompanion(
        motivo: Value(motivo), 
        amount: Value(newAmount),
        initialAmount: Value(newAmount), // Resetting budget base
      ));
}

Future restarGasto(int id, double amountToSubtract) async {
  List<Gasto> curr = await (gastosDatabase.select(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).get();

  return (gastosDatabase.update(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).write(
    GastosCompanion(amount: Value(curr.first.amount - amountToSubtract)),
  );
}

Future sumarGasto(int id, double amountToAdd) async {
  List<Gasto> curr = await (gastosDatabase.select(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).get();

  return (gastosDatabase.update(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).write(
    GastosCompanion(
      amount: Value(curr.first.amount + amountToAdd),
      initialAmount: Value(curr.first.initialAmount + amountToAdd),
    ),
  );
}

//Tabla Gastos Items
Future<List<GastosItem>> readAllGastosItems() async {
  List<GastosItem> allGastosItems = await gastosDatabase
      .select(gastosDatabase.gastosItems)
      .get();
  return allGastosItems;
}

Future<void> writeGastoItem(
  int gastoId,
  String description,
  DateTime date,
  double amount,
  String category,
  String type,
) async {
  await gastosDatabase
      .into(gastosDatabase.gastosItems)
      .insert(
        GastosItemsCompanion.insert(
          gastoId: gastoId,
          description: description,
          date: date,
          amount: amount,
          category: category,
          type: type,
        ),
      );
}

Future deleteGastoItem(int id) async {
  return (gastosDatabase.delete(
    gastosDatabase.gastosItems,
  )..where((t) => t.id.equals(id))).go();
}

Future updateGastoItem(
  int id,
  int gastoId,
  String description,
  DateTime date,
  double amount,
  String category,
  String type,
) async {
  return (gastosDatabase.update(
    gastosDatabase.gastosItems,
  )..where((t) => t.id.equals(id))).write(
    GastosItemsCompanion(
      gastoId: Value(gastoId),
      amount: Value(amount),
      description: Value(description),
      date: Value(date),
      category: Value(category),
      type: Value(type),
    ),
  );
}
//Tabla Gastos Historial Cerrado (Externo)
Future<List<GastosHistorialCerradoData>> readHistoryCerradoByGastoId(int gastoId) async {
  return await (gastosDatabase.select(gastosDatabase.gastosHistorialCerrado)
    ..where((t) => t.gastoId.equals(gastoId))).get();
}

Future<void> writeHistoryCerrado(
  int gastoId,
  String periodLabel,
  String jsonPath,
  double totalSpent,
) async {
  await gastosDatabase.into(gastosDatabase.gastosHistorialCerrado).insert(
    GastosHistorialCerradoCompanion.insert(
      gastoId: gastoId,
      periodLabel: periodLabel,
      jsonPath: jsonPath,
      totalSpent: totalSpent,
    ),
  );
}

Future<void> resetGastoPeriod(int id, double initialAmount, DateTime newDate) async {
  await (gastosDatabase.update(gastosDatabase.gastos)
    ..where((t) => t.id.equals(id)))
  .write(GastosCompanion(
    amount: Value(initialAmount),
    lastResetDate: Value(newDate),
  ));
  
  // Delete current items from DB for this budget (as they are now in JSON)
  await (gastosDatabase.delete(gastosDatabase.gastosItems)
    ..where((t) => t.gastoId.equals(id)))
  .go();
}
