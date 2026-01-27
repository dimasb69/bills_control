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

Future<void> writeGasto(String motivo, DateTime date, double amount) async {
  await gastosDatabase
      .into(gastosDatabase.gastos)
      .insert(
        GastosCompanion.insert(motivo: motivo, date: date, amount: amount),
      );
}

Future<List<Gasto>> readGastoById(int id) async {
  List<Gasto> gasto = await (gastosDatabase.select(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).get();
  return gasto;
}

Future deleteGasto(int id) async {
  final gastoItems = await (gastosDatabase.select(
    gastosDatabase.gastosItems,
  )..where((t) => t.gastoId.equals(id))).get();

  for (var gastoItem in gastoItems) {
    await deleteGastoItem(gastoItem.id);
  }

  return (gastosDatabase.delete(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).go();
}

Future updateGasto(int id, String motivo, double newAmount) async {
  return (gastosDatabase.update(gastosDatabase.gastos)
        ..where((t) => t.id.equals(id)))
      .write(GastosCompanion(motivo: Value(motivo), amount: Value(newAmount)));
}

Future restarGasto(int id, double newAmount) async {
  List<Gasto> currAmount = await (gastosDatabase.select(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).get();

  return (gastosDatabase.update(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).write(
    GastosCompanion(amount: Value(currAmount.first.amount - newAmount)),
  );
}

Future sumarGasto(int id, double newAmount) async {
  List<Gasto> currAmount = await (gastosDatabase.select(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).get();

  return (gastosDatabase.update(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).write(
    GastosCompanion(amount: Value(currAmount.first.amount + newAmount)),
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
