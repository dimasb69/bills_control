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

class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 2, max: 32)();
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get showAutoHelp => boolean().withDefault(const Constant(true))();
}

@DriftDatabase(tables: [Gastos, GastosItems, Categorias, AppSettings])
class GastosDatabase extends _$GastosDatabase {
  GastosDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.createTable(categorias);
        }
        if (from < 3) {
          await m.createTable(appSettings);
        }
      },
    );
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'gastos_db',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
