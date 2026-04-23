import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<bool?> {
  SettingsCubit() : super(null);

  Future<void> getSettings() async {
    try {
      final settings = await readSettings();
      if (settings != null) {
        emit(settings.showAutoHelp);
      } else {
        // Default to true
        emit(true);
      }
    } catch (e) {
      // If DB fails (e.g. migration error or storage), default to true to not break UI
      emit(true);
    }
  }

  Future<void> toggleAutoHelp(bool value) async {
    await updateSettings(value);
    emit(value);
  }
}
