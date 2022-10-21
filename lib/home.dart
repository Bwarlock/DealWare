import 'package:flutter/material.dart';
import 'package:dealware/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> store = [
    "2game",
    "AllYouPlay",
    "Amazon",
    "Blizzard",
    "Direct2Drive",
    "DLGamer",
    "Dreamgame",
    "Epic Game Store",
    "eTail.Market",
    "Fanatical",
    "FireFlower",
    "Game Jolt",
    "GameBillet",
    "GamersGate",
    "Gamerload",
    "GamesPlanet DE",
    "GamesPlanet FR",
    "GamesPlanet UK",
    "GamesPlanet US",
    "GamesRepublic",
    "GameStop PC",
    "GOG",
    "GreenManGaming",
    "Humble Store",
    "Humble Widgets",
    "IndieGala Store",
    "Itch.io",
    "JoyBuggy",
    "MacGamesStore",
    "Microsoft Store",
    "Newegg",
    "Noctre",
    "Nuuvem",
    "Origin",
    "Square Enix",
    "Steam",
    "Ubisoft Store",
    "Voidu",
    "WinGameStore"
  ];
  final List<String> gameType = [
    "DLC",
    "Package",
    "Early Access",
    "Trading Cards",
    "Achievements"
  ];

  Widget getTile(String str) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      leading: Text(
        str,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      trailing: Checkbox(
        value: false,
        onChanged: (isChanged) {},
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text(
                  "Settings",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.settings),
                title: const Text(
                  "Free Games",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                trailing: Checkbox(
                  value: false,
                  onChanged: (isChanged) {},
                ),
                onTap: () {},
              ),
            ),
            ListTile(
              leading: const Text(
                "Filters",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onTap: () {},
            ),
            ExpansionTile(
              title: const Text(
                "Store",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              children: store.map((str) => getTile(str)).toList(),
            ),
            ExpansionTile(
              title: const Text(
                "Price",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SizedBox(
                      width: 80,
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "min",
                          filled: true,
                        ),
                      ),
                    ),
                    Text("to"),
                    SizedBox(
                      width: 80,
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "max",
                          filled: true,
                        ),
                      ),
                    ),
                    Icon(Icons.add_box),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                "Price Cut %",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SizedBox(
                      width: 80,
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                          filled: true,
                        ),
                      ),
                    ),
                    Text("to"),
                    SizedBox(
                      width: 80,
                      height: 50,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "100",
                          filled: true,
                        ),
                      ),
                    ),
                    Icon(Icons.add_box),
                  ],
                ),
              ],
            ),
            ExpansionTile(
              title: const Text(
                "Game Type",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              children: gameType.map((str) => getTile(str)).toList(),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 80,
              height: 50,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "min",
                  filled: true,
                ),
              ),
            ),
            const Text("Hiiiii"),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                color: Colors.red,
                width: 2,
              )),
              child: Image.asset("assets/848450.jpg"),
            ),
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
      ),
    );
  }
}
