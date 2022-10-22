import 'package:flutter/material.dart';
import 'package:dealware/main.dart';
import 'package:dealware/forCheckBox.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> store1 = [
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

  List<ForCheckBox> store = [];

  final List<String> gameType1 = [
    "DLC",
    "Package",
    "Early Access",
    "Trading Cards",
    "Achievements"
  ];

  List<ForCheckBox> gameType = [];
  var minMax = ForCheckBox(str: [0,999], showvalue: false);
  var priceCut = ForCheckBox(str: [0,100], showvalue: false);
  var freeGames = ForCheckBox(str: "Free Games", showvalue: false);
  @override
  void initState() {
    this.store = List<ForCheckBox>.generate(store1.length, (index) => ForCheckBox(str: store1[index], showvalue: false));
    this.gameType = List<ForCheckBox>.generate(gameType1.length, (index) => ForCheckBox(str: gameType1[index], showvalue: false));
    super.initState();
  }

  Widget getTile(ForCheckBox obj) {
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 4, 0),
      leading: Text(
        obj.str,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      trailing: Checkbox(
        value: obj.showvalue,
        onChanged: (value) {
          setState(() {
            obj.showvalue = value!;
        });},
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
                onTap: () {
                  Navigator.pushNamed(context, "/settings");
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.games),
              title: const Text(
                "Free Games",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              trailing: Checkbox(
                value: freeGames.showvalue,
                onChanged: (value) {
                  setState(() {
                    freeGames.showvalue = value!;
                  });
                },
              ),
              onTap: () {},
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
              children: store.map((obj) => getTile(obj)).toList(),
            ),
            ExpansionTile(
              title: const Text(
                "Price",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
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
                      const Text("to"),
                      const SizedBox(
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
                    Checkbox(
                      value: minMax.showvalue,
                      onChanged: (value) {
                        setState(() {
                          minMax.showvalue = value!;
                        });},
                    ),
                    ],
                  ),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
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
                      const Text("to"),
                      const SizedBox(
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
                      Checkbox(
                        value: priceCut.showvalue,
                        onChanged: (value) {
                          setState(() {
                            priceCut.showvalue = value!;
                          });},
                      ),
                    ],
                  ),
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
              children: gameType.map((obj) => getTile(obj)).toList(),
            ),
            Card(
              child: ListTile(
                title: const Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex:2,child: Image.asset("assets/848450.jpg"),),
                    const SizedBox(width: 6,),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: const [Expanded(
                              child: Text("Subnautica: Below Zero",
                                  overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 18,),
                              ),
                            ),],
                          ),
                          Row(
                            children:[
                              Expanded(flex: 5,child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                Container(
                                  padding: const EdgeInsets.all(1),
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                  ),
                                  child: const Center(child: Text("-10%")),
                                ),
                                  const SizedBox(height: 3,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(1),

                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                        ),
                                        child: const Center(child: Text("dlc")),
                                      ),
                                      const SizedBox(width: 3,),
                                      Container(
                                        padding: const EdgeInsets.all(1),

                                        decoration: BoxDecoration(
                                          color: Colors.grey[600],
                                        ),
                                        child: const Center(child: Text("Steam")),
                                      ),
                                    ],
                                  )
                              ],)),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                  Text("\$40.9",
                                    style: TextStyle(
                                      fontSize: 14,
                                      decoration: TextDecoration.lineThrough,
                                      decorationThickness: 1.5,
                                    ),),
                                  SizedBox(height: 5,),
                                  Text("\$40.9",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),),
                                ],),
                              ),

                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
