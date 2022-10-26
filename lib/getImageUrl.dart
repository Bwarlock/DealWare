class GetImageUrl{
  static String getImageUrl(String inSteam){
    if (inSteam != ""){
      var urlList = inSteam.split("/");
      String finalurl = "https://steamcdn-a.akamaihd.net/steam/${urlList[3]}s/${urlList[4]}/header.jpg";
      /*${urlList[3] == "bundle" ? "header_ratio": "header"}*/
      return finalurl;
    }
    return "";
  }
}