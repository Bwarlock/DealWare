import 'package:dealware/getTheCard.dart';
import 'package:flutter/material.dart';

import 'getTheJson.dart';

class SearchList extends StatefulWidget {
  SearchList({ Key? key , required this.title}) : super(key: key);
  final String title;
  @override
  _SearchListState createState() => _SearchListState();

}

class _SearchListState extends State<SearchList> {

  List<Widget> bodyCards = [];

  Widget appBarTitle = Text("Search Sample", style: TextStyle(color: Colors.white),);
  Icon actionIcon = Icon(Icons.search, color: Colors.white,);
  final key = GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = TextEditingController();


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: buildBar(context),
      body: ListView(

        children: [
          ...bodyCards,
        ],
      ),
    );
  }

  void _buildQuery(String value) async{
    try {
      bodyCards = [];
      Map checkType = {};
      Map price = {};
      int limit = 50;
      var api_key = "d7a507d40b74fd5e8fa636feca3b145fdc9bd7e2";
      var searchUrl = "https://api.isthereanydeal.com/v02/search/search/?key=";
      var checkTypeUrl = "https://api.isthereanydeal.com/v01/game/info/?key=";
      var priceUrl = "https://api.isthereanydeal.com/v01/game/prices/?key=";

      Map data1 = await GetTheJson.getTheJson("$searchUrl$api_key&q=$value&limit=$limit");
      if (data1.isEmpty){
        return ;
      }

      List<String> plainList = List<String>.generate(data1["data"]["results"].length, (index) => data1["data"]["results"][index]["plain"]);
      var plains = plainList.join("%2C");

      checkType = (await GetTheJson.getTheJson("$checkTypeUrl$api_key&plains=$plains"))["data"] ?? {};
      if (checkType.isEmpty){
        return ;
      }

      price = (await GetTheJson.getTheJson("$priceUrl$api_key&plains=$plains"))["data"] ?? {};

      for (var dat in plainList){
        if(price[dat]["list"].isEmpty){continue;}

        bodyCards.add(
          GetTheCard(
              (checkType[dat] ?? {})["image"] ?? "",
              checkType[dat]["title"],
              price[dat]["list"][0]["price_old"] ?? "null",
              price[dat]["list"][0]["price_new"] ?? "null",
              price[dat]["list"][0]["price_cut"] ?? "null",
              (price[dat]["list"][0]["shop"] ?? {})["name"] ?? "Unknown",
              (checkType[dat] ?? {})["is_dlc"] ?? false,
              (checkType[dat] ?? {})["is_package"] ?? false,
              (checkType[dat] ?? {})["early_access"] ?? false,
              (checkType[dat] ?? {})["trading_cards"] ?? false,
              (checkType[dat] ?? {})["achievements"] ?? false
          )
        );
      }


      setState(() {});
    } catch (e,stac) {
      print(e);
      print(stac);
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
                  onSubmitted: (value){
                    /*_IsSearching = true;*/
                    _buildQuery(value);
                  },
                );
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
        ]
    );
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = const Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      Text(widget.title, style: const TextStyle(color: Colors.white),);
      /*_IsSearching = false;*/
      _searchQuery.clear();
    });
  }

}
