import 'package:flutter/material.dart';
import 'package:dealware/forCheckBox.dart';
import 'package:synchronized/synchronized.dart';


import 'package:dealware/getTheCard.dart';
import 'package:dealware/getTheJson.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //Store's List
  final List<ForCheckBox> store = [
    ForCheckBox(str: "2game", showvalue: false, store: "game2"),
    ForCheckBox(str: "AllYouPlay", showvalue: false, store: "allyouplay"),
    ForCheckBox(str: "Amazon", showvalue: false, store: "amazonus"),
    ForCheckBox(str: "Blizzard", showvalue: false, store: "battlenet"),
    ForCheckBox(str: "Direct2Drive", showvalue: false, store: "direct2drive"),
    ForCheckBox(str: "DLGamer", showvalue: false, store: "dlgamer"),
    ForCheckBox(str: "Dreamgame", showvalue: false, store: "dreamgame"),
    ForCheckBox(str: "Epic Game Store", showvalue: true, store: "epic"),
    ForCheckBox(str: "eTail.Market", showvalue: false, store: "etailmarket"),
    ForCheckBox(str: "Fanatical", showvalue: true, store: "bundlestars"),
    ForCheckBox(str: "FireFlower", showvalue: false, store: "fireflower"),
    ForCheckBox(str: "Game Jolt", showvalue: false, store: "gamejolt"),
    ForCheckBox(str: "GameBillet", showvalue: false, store: "gamebillet"),
    ForCheckBox(str: "GamersGate", showvalue: false, store: "gamersgate"),
    ForCheckBox(str: "Gamesload", showvalue: false, store: "gamesload"),
    ForCheckBox(str: "GamesPlanet DE", showvalue: false, store: "gamesplanetde"),
    ForCheckBox(str: "GamesPlanet FR", showvalue: false, store: "gamesplanetfr"),
    ForCheckBox(str: "GamesPlanet UK", showvalue: false, store: "gamesplanet"),
    ForCheckBox(str: "GamesPlanet US", showvalue: false, store: "gamesplanetus"),
    ForCheckBox(str: "GamesRepublic", showvalue: false, store: "gamesrepublic"),
    ForCheckBox(str: "GameStop PC", showvalue: false, store: "impulse"),
    ForCheckBox(str: "GOG", showvalue: true, store: "gog"),
    ForCheckBox(str: "GreenManGaming", showvalue: false, store: "greenmangaming"),
    ForCheckBox(str: "Humble Store", showvalue: true, store: "humblestore"),
    ForCheckBox(str: "Humble Widgets", showvalue: false, store: "humblewidgets"),
    ForCheckBox(str: "IndieGala Store", showvalue: true, store: "indiegalastore"),
    ForCheckBox(str: "Itch.io", showvalue: false, store: "itchio"),
    ForCheckBox(str: "JoyBuggy", showvalue: false, store: "joybuggy"),
    ForCheckBox(str: "MacGamesStore", showvalue: false, store: "macgamestore"),
    ForCheckBox(str: "Microsoft Store", showvalue: false, store: "microsoft"),
    ForCheckBox(str: "Newegg", showvalue: false, store: "newegg"),
    ForCheckBox(str: "Noctre", showvalue: false, store: "noctre"),
    ForCheckBox(str: "Nuuvem", showvalue: false, store: "nuuvem"),
    ForCheckBox(str: "Origin", showvalue: false, store: "origin"),
    ForCheckBox(str: "Square Enix", showvalue: false, store: "squenix"),
    ForCheckBox(str: "Steam", showvalue: true, store: "steam"),
    ForCheckBox(str: "Ubisoft Store", showvalue: false, store: "uplay"),
    ForCheckBox(str: "Voidu", showvalue: false, store: "voidu"),
    ForCheckBox(str: "WinGameStore", showvalue: false, store: "wingamestore"),
  ];

  //GameType's List
  final List<ForCheckBox> gameType = [
    ForCheckBox(str: "DLC", showvalue: true),
    ForCheckBox(str: "Package", showvalue: true),
    ForCheckBox(str: "Early Access", showvalue: true),
  ];

  final List<ForCheckBox> sortCheck = [
    ForCheckBox(str: "Time", showvalue: false , store: "time:" , isSortAsc: true),
    ForCheckBox(str: "Price", showvalue: false , store: "price:" , isSortAsc: true),
    ForCheckBox(str: "Price Cut", showvalue: true , store: "cut:" , isSortAsc: false),
    ForCheckBox(str: "Expiry", showvalue: false , store: "expiry:" , isSortAsc: true),
  ];

  //All checkbox
  var Allstore = ForCheckBox(str: "All", showvalue: false);
  var AllgameType = ForCheckBox(str: "All", showvalue: true);


  bool check = false;
  IconData ico = Icons.arrow_downward;

  var lock = Lock();
  final RefreshController refreshController = RefreshController(initialRefresh: false);
  var minTxt = TextEditingController();
  var maxTxt = TextEditingController();
  var priceLowTxt = TextEditingController();
  var priceHighTxt = TextEditingController();

  //offset limit for pagination
  int offset = 0;
  int limit = 25;
  late int totalDeals;

  List data = [];
  Map checkType = {};
  /*Map overview = {};*/
  List<Widget> bodyCards = [];

  var minMax = ForCheckBox(str: [0.0, 99999.0], showvalue: true);
  var priceCut = ForCheckBox(str: [0.0, 100.0], showvalue: true);
  //Previous stored values for freeGame switch
  var previousMinMax = [0.0, 99999.0,"",""];
  var previousPriceCut = [0.0, 100.0,"",""];
  var freeGames = ForCheckBox(str: "Free Games", showvalue: true);

  //Search Queries
  Widget appBarTitle = const Text("Dealware", style: TextStyle(color: Colors.white),);
  Icon actionIcon = Icon(Icons.search, color: Colors.white,);
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();
  List<String> _list = [];
  bool _IsSearching = false;
  String _searchText = "";

  _MyHomePageState(){
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    EnableFreeGames(true);

    _IsSearching = false;

    queryBuilder(isRefresh: true);
  }


  void EnableFreeGames(bool? value){
    if(value == null){
      return;
    }
    if (value == true){
      Allstore.showvalue = false;
      for(var value1 in store){
        var check = value1.store;
        if (check == "epic" || check == "bundlestars" || check == "gog" || check == "humblestore" || check == "indiegalastore" || check == "steam"){
          value1.showvalue = true;
        }
        else{
          value1.showvalue = false;
        }
      }

      for(var value1 in sortCheck){
        if (value1.store == "cut:"){
          sortChange(value1);
          value1.isSortAsc = false;
        }
      }

      previousMinMax[0] = minMax.str[0];
      previousMinMax[1] = minMax.str[1];
      previousMinMax[2] = minTxt.text;
      previousMinMax[3] = maxTxt.text;

      previousPriceCut[0] = priceCut.str[0];
      previousPriceCut[1] = priceCut.str[1];
      previousPriceCut[2] = priceLowTxt.text;
      previousPriceCut[3] = priceHighTxt.text;

      minTxt.text = "0";
      maxTxt.text = "0";
      priceLowTxt.text = "100";
      priceHighTxt.text = "100";
      minMax.str[0] = 0.0;
      minMax.str[1] = 0.0;
      priceCut.str[0] = 100.0;
      priceCut.str[1] = 100.0;
      minMax.showvalue = true;
      priceCut.showvalue = true;
    }
    if(value == false){
      minMax.showvalue = false;
      minMax.str[0] = previousMinMax[0];
      minMax.str[1] = previousMinMax[1];
      minTxt.text = previousMinMax[2].toString();
      maxTxt.text = previousMinMax[3].toString();

      priceCut.showvalue = false;
      priceCut.str[0] = previousPriceCut[0];
      priceCut.str[1] = previousPriceCut[1];
      priceLowTxt.text = previousPriceCut[2].toString();
      priceHighTxt.text = previousPriceCut[3].toString();
    }
  }

  void changeThePrice(ForCheckBox realPrice,int indexToChange,TextEditingController cont,{bool isCut = false}){
    //Function for price textboxes Logic
    try{
      var inp = double.parse(cont.text);
      if (isCut){
        if (inp != null && (inp < 0 || inp > 100)){
          cont.text = "";
        }
      }

      if(inp != null && cont.text != ""){
        realPrice.str[indexToChange] = inp;
      }
    }
    catch(e){
      print(e);
      cont.text = "";
    }

  }

  Future<bool> queryBuilder({bool isRefresh = false}) async {
    await lock.synchronized(() async {
      try {
        var api_key = "d7a507d40b74fd5e8fa636feca3b145fdc9bd7e2";
        var dealUrl = "https://api.isthereanydeal.com/v01/deals/list/?key=";
        var checkTypeUrl = "https://api.isthereanydeal.com/v01/game/info/?key=";
        /*var overviewUrl = "https://api.isthereanydeal.com/v01/game/overview/?key=";*/

        if(isRefresh){
          data = [];
          checkType = {};
          bodyCards = [];
          _list = [];
          offset = 0;
          limit = 25;
        }
        else{
          if(offset > totalDeals || freeGames.showvalue == true){
            refreshController.loadNoData();
            return false;
          }
        }
        if(freeGames.showvalue == true){
          offset = 0;
          limit = 75;
        }

        var region = "";
        var country = "";
        var sort = "";
        for (var i in sortCheck){
          if (i.showvalue == true){
            sort = i.store + (i.isSortAsc ? "asc" : "desc");
          }
        }
        List<String> shopList = [];
        for (var i in store){
          if (i.showvalue == true){
            shopList.add(i.store);
          }
        }
        var shops = shopList.join("%2C");

        List<double>? minMaxList;
        List<double>? priceCutList;
        if (minMax.showvalue){minMaxList = minMax.str;}
        if (priceCut.showvalue){priceCutList = priceCut.str;}
;

        Map data1 = await GetTheJson.getTheJson("$dealUrl$api_key&offset=$offset&limit=$limit&region=$region&country=$country&shops=$shops&sort=$sort");
        if (data1.isEmpty){
          return false;
        }

        totalDeals = data1["data"]["count"];

        data.addAll(data1["data"]["list"]);


        //Taking out all the plains for further info
        List<String> plainList = List<String>.generate(data1["data"]["list"].length, (index) => data1["data"]["list"][index]["plain"]);
        var plains = plainList.join("%2C");

        Map checkType1 = await GetTheJson.getTheJson("$checkTypeUrl$api_key&plains=$plains");
        if (checkType1.isEmpty){
          return false;
        }
        checkType.addAll(checkType1["data"]);


        //Incrementing the offset and limit
        offset += 25;


        for (var dat in data1["data"]["list"]){
          if (dat["price_new"] < minMax.str[0] || dat["price_new"] > minMax.str[1]){continue;}
          if (dat["price_cut"] < priceCut.str[0] || dat["price_cut"] > priceCut.str[1]){continue;}
          if (gameType[0].showvalue == false && (checkType[dat["plain"]] ?? {})["is_dlc"] ?? false) {continue;}
          if (gameType[1].showvalue == false && (checkType[dat["plain"]] ?? {})["is_package"] ?? false) {continue;}
          if (gameType[2].showvalue == false && (checkType[dat["plain"]] ?? {})["early_access"] ?? false) {continue;}

          bodyCards.add(GetTheCard(

              (checkType[dat["plain"]] ?? {})["image"] ?? "",
              dat["title"],
              dat["price_old"], dat["price_new"], dat["price_cut"],
              dat["shop"]["name"],
              (checkType[dat["plain"]] ?? {})["is_dlc"] ?? false,
              (checkType[dat["plain"]] ?? {})["is_package"] ?? false,
              (checkType[dat["plain"]] ?? {})["early_access"] ?? false,
              (checkType[dat["plain"]] ?? {})["trading_cards"] ?? false,
              (checkType[dat["plain"]] ?? {})["achievements"] ?? false
          ));
          _list.add(dat["title"]);
        }

        setState(() {});
        return true;
      } catch (e, stacktrace) {
        print(e);
        print(stacktrace);
        return false;
      }
    });
    return false;
  }

  IconData getAscDesc(bool isAsc){
    if (isAsc){
      return Icons.arrow_upward;
    }
    else{
      return Icons.arrow_downward;
    }
  }

  void sortChange(ForCheckBox obj){
    if (obj.showvalue == false) {
      for (var i in sortCheck) {
        if (i != obj) {
          i.isSortAsc = true;
          i.showvalue = false;
        }
      }
      obj.showvalue = true;
    }
    obj.isSortAsc = !obj.isSortAsc;
  }

  Widget getSortTile(ForCheckBox obj){
    return ListTile(
      contentPadding: const EdgeInsets.fromLTRB(15, 0, 16, 0),
      title: Text(
        obj.str,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      trailing: Icon( getAscDesc(obj.isSortAsc) ),
      selected: obj.showvalue,
      onTap: (){
        setState(() {
          sortChange(obj);
        });
      },
    );
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


  List<Widget> _buildSearchList() {
    if (_searchText.isEmpty) {
      return bodyCards;
    }
    else {
      List<Widget> _searchList = [];
      for (int i = 0; i < _list.length; i++) {
        String  name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(bodyCards.elementAt(i));
        }
      }
      return _searchList;
    }
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
        title: appBarTitle,
        actions: <Widget>[
          IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = const Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = TextField(
                  controller: _searchQuery,
                  style: const TextStyle(
                    color: Colors.white,

                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = const Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      Text(widget.title, style: TextStyle(color: Colors.white),);
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

  Widget getBodyChild(){
    if(_IsSearching){
      return ListView(
        children: _buildSearchList(),
      );
    }
    else{
      return SmartRefresher(
        controller: refreshController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: () async{
          final bool result = await queryBuilder(isRefresh: true);
          if(result){
            refreshController.refreshCompleted();
          }
          else{
            refreshController.refreshFailed();
          }
        },
        onLoading: () async{
          final bool result = await queryBuilder();
          if(result){
            refreshController.loadComplete();
          }
          else{
            refreshController.loadFailed();
          }
        },
        child: ListView(
          children: [
            ...bodyCards,

          ],
        ),

      );
    }
  }
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called

    return Scaffold(
      appBar: buildBar(context),
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
            Card(
              child: ListTile(
                leading: const Icon(Icons.search),
                title: const Text(
                  "Search Game",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, "/search");
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
                    EnableFreeGames(value);
                    freeGames.showvalue = value!;
                  });
                },
              ),
              onTap: () {
                setState(() {
                  EnableFreeGames(!freeGames.showvalue);
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
                  "Sort",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              children: [
                ...sortCheck.map((obj) => getSortTile(obj)).toList(),
              ],
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: minTxt,
                          onSubmitted: (value){
                            changeThePrice(minMax, 0, minTxt);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "min",
                            filled: true,
                          ),
                        ),
                      ),
                      const Text("to"),
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: maxTxt,
                          onSubmitted: (value){
                            changeThePrice(minMax, 1, maxTxt);
                          },
                          decoration: const InputDecoration(
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
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: priceLowTxt,
                          onSubmitted: (value){
                            changeThePrice(priceCut, 0, priceLowTxt, isCut:true);
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "0",
                            filled: true,
                          ),
                        ),
                      ),
                      const Text("to"),
                      SizedBox(
                        width: 80,
                        height: 50,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: priceHighTxt,
                          onSubmitted: (value){
                            changeThePrice(priceCut, 1, priceHighTxt, isCut:true);
                          },
                          decoration: const InputDecoration(
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
                /*tileColor: Colors.grey[400],*/
                title: const Center(
                  child: Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                onTap: () {
                  /*bodyCards.clear();*/
                  queryBuilder(isRefresh:true);
                },
              ),
            ),
          ],
        ),
      ),
      body: getBodyChild(),
    );
  }
}

