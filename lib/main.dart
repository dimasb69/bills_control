import 'package:bills_control/screens/home.dart';
import 'package:bills_control/themes.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bills_control/cubits/cubitsAll.dart';

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
            BlocProvider(create: (context) => GastosCubits()),
            BlocProvider(create: (context) => GastosHistorialCubits()),
          ],
          child: const MyApp(),
        );
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GastosCubits>().getGastos();
    return FlutterSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: "Control de Gastos",
          debugShowCheckedModeBanner: false,
          theme: AppThemes.slate,
          darkTheme: AppThemes.sage,
          themeMode: ThemeMode.system,
          home: const Home(),
        );
      },
    );
  }
}
