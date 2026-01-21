import 'package:bills_control/data_base/gastos.dart';
import 'package:drift/drift.dart';

final gastosDatabase = GastosDatabase();

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

Future deleteGasto(int id) async {
  return (gastosDatabase.delete(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).go();
}

Future updateGasto(int id, double newAmount) async {
  List<Gasto> currAmount = await (gastosDatabase.select(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).get();

  return (gastosDatabase.update(
    gastosDatabase.gastos,
  )..where((t) => t.id.equals(id))).write(
    GastosCompanion(amount: Value(currAmount.first.amount - newAmount)),
  );
}
