import 'package:flutter/material.dart';
import 'themes.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Bills Control",
      debugShowCheckedModeBanner: false,
      theme: AppThemes.slate,
      darkTheme: AppThemes.sage,
      themeMode: ThemeMode.system, // Allows toggling via system settings
      home: Scaffold(
        appBar: AppBar(title: const Text("Bills Control")),
        body: Center(child: Text("Hello World")),
      ),
    );
  }
}
