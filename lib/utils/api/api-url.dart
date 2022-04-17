import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiUrl{
  static String stringUri(
    var method, double longitude, double latitude, 
  ) {
    // method = today/this_week/this_month

    //Jakarta
    // "latitude": -6.208763599395752,
    // "longitude": 106.84559631347656,

    return 'https://api.pray.zone/v2/times/$method.json?longitude=$longitude&latitude=$latitude&elevation=15';
  }

  static Future<dynamic> get(var method, double latitude, double longitude) async {
    try {
      var response = await http.get(Uri.parse(stringUri(method, longitude, latitude)));

      var responseJson = json.decode(response.body);
      if(response.statusCode == 200){
        return responseJson;
      }else{
        print(response.request);
        return null;
      }
    } catch (e) {
      print(e);
    }
  }
}