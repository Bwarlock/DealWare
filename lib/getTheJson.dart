import 'dart:convert';
import 'package:http/http.dart';

class GetTheJson {
  static Future<Map> getTheJson(String INurl) async{
    try {
      var url = Uri.parse(INurl);
      Response res = await get(url);
      if(res.statusCode == 200){
        Map data = jsonDecode(res.body);
        return data;
      }
      return {};
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return {};
    }
  }
}