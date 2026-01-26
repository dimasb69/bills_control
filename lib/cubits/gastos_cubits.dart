import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';

class GastosCubits extends Cubit<List<Gasto>> {
  GastosCubits() : super([]);

  void getGastos() async {
    emit(await readAllGastos());
  }

  void dellGasto(int dellId) async {
    emit(state.where((gasto) => gasto.id != dellId).toList());
    await deleteGasto(dellId);
  }
}
