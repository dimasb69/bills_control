import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';

//Gastos
class GastosCubits extends Cubit<List<Gasto>> {
  GastosCubits() : super([]);

  void getGastos() async {
    emit(await readAllGastos());
  }

  void dellGasto(int dellId) async {
    emit(state.where((gasto) => gasto.id != dellId).toList());
    await deleteGasto(dellId);
  }

  void updGasto(int id, String motivo, double amount, DateTime date) async {
    emit(
      state
          .map(
            (gasto) => gasto.id == id
                ? Gasto(id: id, motivo: motivo, amount: amount, date: date)
                : gasto,
          )
          .toList(),
    );
    await updateGasto(id, motivo, amount);
  }

  void resGasto(int id, double amount) async {
    emit(
      state
          .map(
            (gasto) => gasto.id == id
                ? Gasto(
                    id: id,
                    motivo: gasto.motivo,
                    amount: gasto.amount - amount,
                    date: gasto.date,
                  )
                : gasto,
          )
          .toList(),
    );
    await restarGasto(id, amount);
  }

  void sumGasto(int id, double amount) async {
    emit(
      state
          .map(
            (gasto) => gasto.id == id
                ? Gasto(
                    id: id,
                    motivo: gasto.motivo,
                    amount: gasto.amount + amount,
                    date: gasto.date,
                  )
                : gasto,
          )
          .toList(),
    );
    await sumarGasto(id, amount);
  }
}

//GastosHistorial
class GastosHistorialCubits extends Cubit<List<GastosItem>> {
  GastosHistorialCubits() : super([]);

  void getGastosItems() async {
    emit(await readAllGastosItems());
  }

  void dellGastoItem(int dellId) async {
    emit(state.where((gastoItem) => gastoItem.id != dellId).toList());
    await deleteGastoItem(dellId);
  }

  void updGastoItem(
    int id,
    int gastoId,
    String description,
    double amount,
    DateTime date,
    String category,
    String type,
  ) async {
    emit(
      state
          .map(
            (gastoItem) => gastoItem.id == id
                ? GastosItem(
                    id: gastoItem.id,
                    gastoId: gastoId,
                    description: description,
                    date: date,
                    amount: amount,
                    category: category,
                    type: type,
                  )
                : gastoItem,
          )
          .toList(),
    );
    await updateGastoItem(
      id,
      gastoId,
      description,
      date,
      amount,
      category,
      type,
    );
  }
}
