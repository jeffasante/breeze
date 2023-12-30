import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {
  String location = ''; // location name for the UI
  String time = ''; // the time in that location
  String flag = ''; // url to an asset flag icon
  String url = ''; // location url for api endpoint
  bool isDayTime = false; // true or false if day time or not

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      // Await the http get response, then decode the json-formatted response.
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      // Get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime + " - " + offset);

      // Create a datetime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));


      // set the time property
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
      
    } catch (e) {
      print('caught error: $e');
      time = 'could not get time data';
    }
  }
}
