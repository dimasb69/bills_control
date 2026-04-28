import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'gastos.g.dart';

class Gastos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get motivo => text().withLength(min: 4, max: 32)();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  RealColumn get initialAmount => real().withDefault(const Constant(0))();
  TextColumn get type => text().withDefault(const Constant('normal'))();
  DateTimeColumn get lastResetDate => dateTime().nullable()();
}

class GastosItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gastoId =>
      integer().references(Gastos, #id, onDelete: KeyAction.cascade)();
  TextColumn get description => text().withLength(min: 4, max: 32)();
  DateTimeColumn get date => dateTime()();
  RealColumn get amount => real()();
  TextColumn get category => text()();
  TextColumn get type => text()();
}

class GastosHistorialCerrado extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gastoId =>
      integer().references(Gastos, #id, onDelete: KeyAction.cascade)();
  TextColumn get periodLabel => text()();
  TextColumn get jsonPath => text()();
  RealColumn get totalSpent => real()();
  // 'monthly' o 'annual'
  TextColumn get periodType => text().withDefault(const Constant('monthly'))();
}

class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 2, max: 32)();
}

class AppSettings extends Table {
  IntColumn get id => integer().autoIncrement()();
  BoolColumn get showAutoHelp => boolean().withDefault(const Constant(true))();
}

@DriftDatabase(tables: [Gastos, GastosItems, GastosHistorialCerrado, Categorias, AppSettings])
class GastosDatabase extends _$GastosDatabase {
  GastosDatabase([QueryExecutor? executor])
      : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 6;

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
        if (from < 4) {
          // In SQLite, to change a Foreign Key we must recreate the table.
          // This will apply the new KeyAction.cascade constraint.
          await m.deleteTable('gastos_items');
          await m.createTable(gastosItems);
        }
        if (from < 5) {
          // New columns in Gastos
          await m.addColumn(gastos, gastos.initialAmount);
          await m.addColumn(gastos, gastos.type);
          await m.addColumn(gastos, gastos.lastResetDate);
          // New table
          await m.createTable(gastosHistorialCerrado);
        }
        if (from < 6) {
          // Add periodType column to GastosHistorialCerrado (default 'monthly')
          await m.addColumn(gastosHistorialCerrado, gastosHistorialCerrado.periodType);
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
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
