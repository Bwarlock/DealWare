import 'package:flutter/material.dart';
import 'package:dealware/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue,),
      darkTheme: ThemeData.dark(), // standard dark theme
      themeMode: _themeMode, // device controls theme
      home: const MyHomePage(title: 'Dealware'),
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  // MyApp.of(context).changeTheme(ThemeMode.light)
  // MyApp.of(context).changeTheme(ThemeMode.dark)
}


