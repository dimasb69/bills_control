import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'gastos.g.dart';

class Gastos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get motivo => text().withLength(min: 4, max: 32)();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
}

class GastosItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gastoId => integer().references(Gastos, #id)();
  TextColumn get description => text().withLength(min: 4, max: 32)();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  TextColumn get type => text()();
}

@DriftDatabase(tables: [Gastos, GastosItems])
class GastosDatabase extends _$GastosDatabase {
  GastosDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'gastos_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
