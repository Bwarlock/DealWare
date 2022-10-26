import 'dart:convert';
import 'package:dealware/getTheCard.dart';
/*import 'package:flutter/services.dart';*/
import 'package:http/http.dart';
import 'package:dealware/getTheJson.dart';
import 'package:flutter/material.dart';
import 'package:dealware/getImageUrl.dart';
class GetTheData {



  static Future<List<Widget>> getTheData(String INurl, bool isDLC, bool isPackage, bool isEarlyAccess) async{

    try {
      var url = Uri.parse(INurl);
      Response res = await get(url);
      Map data = jsonDecode(res.body);
      /*final String response = await rootBundle.loadString('assets/plainTOid.json');
      print(jsonDecode(response)["data"][0]);*/

      List<String> plainList = List<String>.generate(data["data"]["list"].length, (index) => data["data"]["list"][index]["plain"]);
      var api_key = "d7a507d40b74fd5e8fa636feca3b145fdc9bd7e2";
      var serviceurl = "https://api.isthereanydeal.com/v01/game/info/?key=";
      var plains = plainList.join("%2C");

      Map checkType = await GetTheJson.getTheJson("$serviceurl$api_key&plains=$plains");
      if (checkType.isEmpty){
        print("nothing");
        return [];
      }

      serviceurl = "https://api.isthereanydeal.com/v01/game/overview/?key=";
      Map datOverview  = await GetTheJson.getTheJson("$serviceurl$api_key&plains=$plains&shop=steam&allowed=steam");
      
      List<Widget> finalBody = [];
      /*finalBody.add(GetTheCard.theTile("dat[", 34, 54, 5,
          "steggggg epic toram",
          true,
          true,
          true,
          true,
          true));*/
      for (var dat in data["data"]["list"]){
        if (isDLC == false && checkType["data"][dat["plain"]]["is_dlc"]) {continue;}
        if (isPackage == false && checkType["data"][dat["plain"]]["is_package"]) {continue;}
        if (isEarlyAccess == false && checkType["data"][dat["plain"]]["early_access"]) {continue;}
        finalBody.add(GetTheCard.theTile(
            GetImageUrl.getImageUrl( (((datOverview["data"] ?? Map())[dat["plain"]] ?? Map())["price"] ?? Map())["url"] ?? ""),
            dat["title"],
            dat["price_old"], dat["price_new"], dat["price_cut"],
            dat["shop"]["name"],
            checkType["data"][dat["plain"]]["is_dlc"],
            checkType["data"][dat["plain"]]["is_package"],
            checkType["data"][dat["plain"]]["early_access"],
            checkType["data"][dat["plain"]]["trading_cards"],
            checkType["data"][dat["plain"]]["achievements"]));
      }
      return finalBody;
    } catch (e,stacktrace) {
      print(e);
      print(stacktrace);
      return [];
    }
  }
}