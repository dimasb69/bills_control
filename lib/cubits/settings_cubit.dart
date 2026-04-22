import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<bool?> {
  SettingsCubit() : super(null);

  Future<void> getSettings() async {
    final settings = await readSettings();
    if (settings != null) {
      emit(settings.showAutoHelp);
    } else {
      // Default to true
      emit(true);
    }
  }

  Future<void> toggleAutoHelp(bool value) async {
    await updateSettings(value);
    emit(value);
  }
}
