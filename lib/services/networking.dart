import 'package:http/http.dart' as http;

import '../myweather.dart';

class NetWorkHelper {
  final String url;

  NetWorkHelper(this.url);

  Future getData() async {
    var res = await http.get(url);
    if (res.statusCode == 200) {
      var weather = weatherFromJson(res.body);
      print(res.body);
      return weather;
    } else {
      print(res.statusCode);
      return res.statusCode;
    }
  }
}
