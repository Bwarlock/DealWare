import 'package:flutter/material.dart';
import 'package:dealware/main.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key, required this.title});

  final String title;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Choose your theme:',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /// //////////////////////////////////////////////////////
              /// Change theme & rebuild to show it using these buttons
              ElevatedButton(
                  onPressed: () =>
                      MyApp.of(context).changeTheme(ThemeMode.light),
                  child: const Text('Light')),
              ElevatedButton(
                  onPressed: () =>
                      MyApp.of(context).changeTheme(ThemeMode.dark),
                  child: const Text('Dark')),
              ElevatedButton(
                  onPressed: () =>
                      MyApp.of(context).changeTheme(ThemeMode.system),
                  child: const Text('System')),

              /// //////////////////////////////////////////////////////
            ],
          ),
        ],
      ),
    );
  }
}
