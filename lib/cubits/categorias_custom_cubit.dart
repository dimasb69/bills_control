import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriasCustomCubit extends Cubit<List<Categoria>> {
  CategoriasCustomCubit() : super([]);

  Future<void> getCategorias() async {
    try {
      final categorias = await readAllCategorias();
      emit(categorias);
    } catch (e) {
      emit([]);
    }
  }

  Future<void> addCategoria(String name) async {
    await writeCategoria(name);
    await getCategorias();
  }

  Future<void> removeCategoria(int id) async {
    await deleteCategoria(id);
    await getCategorias();
  }
}
