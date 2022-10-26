import 'package:flutter/material.dart';
import 'package:dealware/forCheckBox.dart';
import 'package:dealware/getTheData.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<ForCheckBox> store = [
    ForCheckBox(str: "2game", showvalue: true, store: "game2"),
    ForCheckBox(str: "AllYouPlay", showvalue: true, store: "allyouplay"),
    ForCheckBox(str: "Amazon", showvalue: true, store: "amazonus"),
    ForCheckBox(str: "Blizzard", showvalue: true, store: "battlenet"),
    ForCheckBox(str: "Direct2Drive", showvalue: true, store: "direct2drive"),
    ForCheckBox(str: "DLGamer", showvalue: true, store: "dlgamer"),
    ForCheckBox(str: "Dreamgame", showvalue: true, store: "dreamgame"),
    ForCheckBox(str: "Epic Game Store", showvalue: true, store: "epic"),
    ForCheckBox(str: "eTail.Market", showvalue: true, store: "etailmarket"),
    ForCheckBox(str: "Fanatical", showvalue: true, store: "bundlestars"),
    ForCheckBox(str: "FireFlower", showvalue: true, store: "fireflower"),
    ForCheckBox(str: "Game Jolt", showvalue: true, store: "gamejolt"),
    ForCheckBox(str: "GameBillet", showvalue: true, store: "gamebillet"),
    ForCheckBox(str: "GamersGate", showvalue: true, store: "gamersgate"),
    ForCheckBox(str: "Gamesload", showvalue: true, store: "gamesload"),
    ForCheckBox(str: "GamesPlanet DE", showvalue: true, store: "gamesplanetde"),
    ForCheckBox(str: "GamesPlanet FR", showvalue: true, store: "gamesplanetfr"),
    ForCheckBox(str: "GamesPlanet UK", showvalue: true, store: "gamesplanet"),
    ForCheckBox(str: "GamesPlanet US", showvalue: true, store: "gamesplanetus"),
    ForCheckBox(str: "GamesRepublic", showvalue: true, store: "gamesrepublic"),
    ForCheckBox(str: "GameStop PC", showvalue: true, store: "impulse"),
    ForCheckBox(str: "GOG", showvalue: true, store: "gog"),
    ForCheckBox(str: "GreenManGaming", showvalue: true, store: "greenmangaming"),
    ForCheckBox(str: "Humble Store", showvalue: true, store: "humblestore"),
    ForCheckBox(str: "Humble Widgets", showvalue: true, store: "humblewidgets"),
    ForCheckBox(str: "IndieGala Store", showvalue: true, store: "indiegalastore"),
    ForCheckBox(str: "Itch.io", showvalue: true, store: "itchio"),
    ForCheckBox(str: "JoyBuggy", showvalue: true, store: "joybuggy"),
    ForCheckBox(str: "MacGamesStore", showvalue: true, store: "macgamestore"),
    ForCheckBox(str: "Microsoft Store", showvalue: true, store: "microsoft"),
    ForCheckBox(str: "Newegg", showvalue: true, store: "newegg"),
    ForCheckBox(str: "Noctre", showvalue: true, store: "noctre"),
    ForCheckBox(str: "Nuuvem", showvalue: true, store: "nuuvem"),
    ForCheckBox(str: "Origin", showvalue: true, store: "origin"),
    ForCheckBox(str: "Square Enix", showvalue: true, store: "squenix"),
    ForCheckBox(str: "Steam", showvalue: true, store: "steam"),
    ForCheckBox(str: "Ubisoft Store", showvalue: true, store: "uplay"),
    ForCheckBox(str: "Voidu", showvalue: true, store: "voidu"),
    ForCheckBox(str: "WinGameStore", showvalue: true, store: "wingamestore"),
  ];

  final List<ForCheckBox> gameType = [
    ForCheckBox(str: "DLC", showvalue: true),
    ForCheckBox(str: "Package", showvalue: true),
    ForCheckBox(str: "Early Access", showvalue: true),
  ];
  var Allstore = ForCheckBox(str: "All", showvalue: true);
  var AllgameType = ForCheckBox(str: "All", showvalue: true);

  List<Widget> bodyCards = [];

  var minMax = ForCheckBox(str: [0, 999], showvalue: false);
  var priceCut = ForCheckBox(str: [0, 100], showvalue: false);
  var freeGames = ForCheckBox(str: "Free Games", showvalue: false);

  @override
  void initState() {
    queryBuilder();
    super.initState();
  }

  void queryBuilder() async {
    var api_key = "d7a507d40b74fd5e8fa636feca3b145fdc9bd7e2";
    var serviceurl = "https://api.isthereanydeal.com/v01/deals/list/?key=";
    var offset = 0;
    var limit = 20;
    var region = "";
    var country = "";
    List<String> shop = [];
    for (var i in store){
      if (i.showvalue == true){
        shop.add(i.store);
      }
    }

    var sort = "cut:desc";
    bodyCards = await  GetTheData.getTheData("$serviceurl$api_key&offset=$offset&limit=$limit&region=$region&country=$country&shops=${shop.join("%2C")}&sort=$sort",
        gameType[0].showvalue,
        gameType[1].showvalue,
        gameType[2].showvalue
    );
    setState(() {
    });
  }

  Widget getAllTile(ForCheckBox obj, List<ForCheckBox> listRef) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
      title: Text(
        obj.str,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      value: obj.showvalue,
      onChanged: (value) {
        setState(() {
          obj.showvalue = value!;
          for (var value1 in listRef) {
            value1.showvalue = value;
          }
        });
      },
    );
  }

  Widget getTile(ForCheckBox obj, ForCheckBox allRef) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 8, 0),
      title: Text(
        obj.str,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      value: obj.showvalue,
      onChanged: (value) {
        setState(() {
          if (allRef.showvalue == true) {
            allRef.showvalue = false;
          }
          obj.showvalue = value!;
        });
      },
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
              onTap: () {
                setState(() {
                  freeGames.showvalue = !freeGames.showvalue;
                });
              },
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
                children: [
                  getAllTile(Allstore, store),
                  ...store.map((obj) => getTile(obj, Allstore)).toList(),
                ]),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          });
                        },
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
                          });
                        },
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
                children: [
                  getAllTile(AllgameType, gameType),
                  ...gameType.map((obj) => getTile(obj, AllgameType)).toList(),
                ]),
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
                onTap: queryBuilder,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          ...bodyCards,

        ],
      ),
    );
  }
}
