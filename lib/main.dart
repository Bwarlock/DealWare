import 'package:dealware/settings.dart';
import 'package:flutter/material.dart';
import 'package:dealware/home.dart';
import 'package:dealware/search.dart';

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
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(primarySwatch: Colors.blue,),
      darkTheme: ThemeData.dark(), // standard dark theme
      themeMode: _themeMode, // device controls theme
      initialRoute: "/home",
      routes: {
        "/home" : (context) => MyHomePage(title: 'Dealware'),
        "/settings" : (context) => Settings(title: 'Settings'),
        "/search" : (context) => SearchList(title: 'Search Game'),
      },
      /*home: const MyHomePage(title: 'Dealware'),*/
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


