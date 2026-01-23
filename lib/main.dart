import 'package:bills_control/data_base/gastos.dart';
import 'package:bills_control/data_base/gastos_crud.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/cubits/constant_cubits.dart';
import 'themes.dart';

List<Gasto> gastosList = [];
TextEditingController motivoController = TextEditingController();
TextEditingController amountController = TextEditingController();
TextEditingController newAmountController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController idController = TextEditingController();
TextEditingController idUpdateController = TextEditingController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => CateHomeCubit()),
            BlocProvider(create: (context) => CateWorkCubit()),
          ],
          child: const MyApp(),
        );
      },
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final cateHomeCubit = context.read<CateHomeCubit>();
    final cateWorkCubit = context.read<CateWorkCubit>();
    cateHomeCubit.state.forEach((element) {
      print(element.name);
    });
    cateWorkCubit.state.forEach((element) {
      print(element.name);
    });
    DateTime now = DateTime.now();
    dateController.text = now.toString();
    return MaterialApp(
      title: "Bills Control",
      debugShowCheckedModeBanner: false,
      theme: AppThemes.slate,
      darkTheme: AppThemes.sage,
      themeMode: ThemeMode.system, // Allows toggling via system settings
      home: Scaffold(
        appBar: AppBar(title: const Text("Bills Control")),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: motivoController,
                  decoration: const InputDecoration(labelText: "Motivo"),
                ),
                TextField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: "Amount"),
                ),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(labelText: "Date"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    writeGasto(
                      motivoController.text,
                      DateTime.parse(dateController.text),
                      double.parse(amountController.text),
                    );
                    gastosList = await readAllGastos();
                    setState(() {
                      gastosList;
                    });
                    motivoController.clear();
                    amountController.clear();
                  },
                  child: const Text("Add Gasto"),
                ),
                Divider(),
                SizedBox(height: 20),
                TextField(
                  controller: idController,
                  decoration: const InputDecoration(labelText: "ID"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    deleteGasto(int.parse(idController.text));
                    gastosList = await readAllGastos();
                    setState(() {
                      gastosList;
                    });
                    idController.clear();
                  },
                  child: const Text("Delete Gasto"),
                ),
                Divider(),
                SizedBox(height: 20),
                TextField(
                  controller: idUpdateController,
                  decoration: const InputDecoration(labelText: "ID"),
                ),
                TextField(
                  controller: newAmountController,
                  decoration: const InputDecoration(labelText: "New Amount"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    updateGasto(
                      int.parse(idUpdateController.text),
                      double.parse(newAmountController.text),
                    );
                    await Future.delayed(const Duration(seconds: 2));
                    gastosList = await readAllGastos();
                    idUpdateController.clear();
                    newAmountController.clear();
                    setState(() {
                      gastosList;
                    });
                  },
                  child: const Text("Update Gasto"),
                ),
                Divider(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    gastosList = await readAllGastos();
                    setState(() {
                      gastosList;
                    });
                  },
                  child: const Text("Read Gasto"),
                ),
                Divider(),
                SizedBox(height: 20),
                for (var i = 0; i < gastosList.length; i++)
                  Column(
                    children: [
                      Text("ID: ${gastosList[i].id}"),
                      Text("Motivo: ${gastosList[i].motivo}"),
                      Text("Amount: ${gastosList[i].amount}"),
                      Text("Date: ${gastosList[i].date}"),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
