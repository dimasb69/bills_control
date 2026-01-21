import 'package:bills_control/data_base/gastos.dart';

final gastosDatabase = GastosDatabase();

Future<void> testDatabase() async {
  await gastosDatabase
      .into(gastosDatabase.gastos)
      .insert(
        GastosCompanion.insert(
          motivo: 'test 1',
          date: DateTime.now(),
          amount: 100,
        ),
      );
  List<Gasto> allGastos = await gastosDatabase
      .select(gastosDatabase.gastos)
      .get();

  await gastosDatabase
      .into(gastosDatabase.gastosItems)
      .insert(
        GastosItemsCompanion.insert(
          gastoId: int.parse(allGastos[0].id.toString()),
          description: 'primer gasto',
          date: DateTime.now(),
          amount: 100,
          category: 'test',
          type: 'test',
        ),
      );

  List<GastosItem> allItems = await gastosDatabase
      .select(gastosDatabase.gastosItems)
      .get();

  print('gastos in database: $allGastos');
  print('items in database: $allItems');
  print('amountLeft: ${allGastos[0].amount - allItems[0].amount}');
}
