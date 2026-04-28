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
    await updateGasto(id, motivo, amount);
    getGastos();
  }

  void resGasto(int id, double amount) async {
    await restarGasto(id, amount);
    getGastos();
  }

  void sumGasto(int id, double amount) async {
    await sumarGasto(id, amount);
    getGastos();
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

  void clearGastosItems() {
    emit([]);
  }
}
