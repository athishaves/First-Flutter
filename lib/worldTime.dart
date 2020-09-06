import 'package:http/http.dart' as http;
import 'dart:convert';

class WorldTime {

  String url;
  DateTime dateTime;

  int noOfDays, noOfWeeks, day;

  WorldTime ({ this.url  });


// {"abbreviation":"ACST","client_ip":"117.200.117.129",
// "datetime":"2020-09-04T22:38:54.476429+09:30",
// "day_of_week":5,"day_of_year":248,
// "dst":false,"dst_from":null,"dst_offset":0,"dst_until":null,
// "raw_offset":34200,"timezone":"Australia/Adelaide","unixtime":1599224934,
// "utc_datetime":"2020-09-04T13:08:54.476429+00:00",
// "utc_offset":"+09:30","week_number":36}


  Future<void> getData(curTime) async {

    Map body;
    try {
      http.Response response = await http.get(
          "http://worldtimeapi.org/api/timezone/${this.url}");
      body = json.decode(response.body);
    } catch (e) {
      print("Exception caught : $e");
      return;
    }

    noOfDays = body['day_of_year'];
    noOfWeeks = body['week_number'];
    day = body['day_of_week'];

    String dt = body['utc_datetime'];
    DateTime now = DateTime.parse(dt);

    String utcOffset = body['utc_offset'];
    print("Utc offset $utcOffset");
    bool isPositive = utcOffset[0]=='+';
    int hr = int.parse(utcOffset.substring(1, 3));
    int mins = int.parse(utcOffset.substring(4, 6));

    // Minimises the time lag
    int curMilli = DateTime.now().millisecond;
    int milli = curMilli > curTime ? curMilli - curTime : 1000 + curMilli - curTime;
    now = now.add(Duration(milliseconds:  milli));

    this.dateTime = isPositive ? now.add(Duration(hours: hr, minutes: mins)) :
                              now.subtract(Duration(hours: hr, minutes: mins));
  }

}