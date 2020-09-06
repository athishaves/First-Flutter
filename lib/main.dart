import 'package:first_flutter/worldTime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_flutter/customText.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:analog_clock/analog_clock.dart';

void main() => runApp(MaterialApp(
  home: Home(),
));


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

  WorldTime worldTime;
  bool isLoading = false;

  Widget loadingIndicator;

  void getTime() async {
    setState(() {
      isLoading = true;
    });

    WorldTime worldTime = WorldTime(url: "Asia/Kolkata");
    await worldTime.getData(DateTime.now().millisecond);

    setState(() {
      this.worldTime = worldTime;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    worldTime = WorldTime();
    getTime();
  }

  @override
  Widget build(BuildContext context) {

    loadingIndicator = Card(
      elevation: 10,
      child: Container(
        width: 175, height: 80,
        color: Colors.grey[50],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: Row(
                children: [
                  CircularProgressIndicator(),
                  Expanded(flex: 1, child: SizedBox()),
                  Text("Loading ..."),
                ],
              )
          ),
        ),
      ),
    );

    return Scaffold(

      appBar: AppBar(
        title: Text("World Clock"),
      ),

      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Stack(
                children: [

                  Column(
                    children: [

                      CustomText(
                        worldTime.url == null ? "" : this.worldTime.url,
                        textStyle: TextStyle(
                          color: Colors.amberAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),

                      Expanded( flex: 1, child: SizedBox()),

                      AnalogClock(

                        decoration: BoxDecoration(
                          gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topRight,
                              colors: [Colors.lightGreenAccent[200], Colors.amberAccent[100], Colors.deepOrangeAccent]),
                          shape: BoxShape.rectangle,
                          color: Colors.grey[100],
                        ),
                        isLive: true,
                        width: 200, height: 200,
                        tickColor: Colors.black,
                        textScaleFactor: 1.25,
                        showDigitalClock: true,
                        datetime: worldTime.dateTime,
                      ),

                      Expanded( flex: 2, child: SizedBox()),

                      CustomText(
                        worldTime.dateTime == null || worldTime.day==null ? "" :
                          "${worldTime.dateTime.day} ${getMonth(worldTime.dateTime.month)} "
                              "${worldTime.dateTime.year} - ${getDay(worldTime.day)}",
                        textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),

                      Expanded( flex: 1, child: SizedBox()),

                      CustomText(
                        worldTime.noOfDays==null || worldTime.noOfWeeks==null ? "" :
                                      "Today is the ${this.worldTime.noOfDays}${getSuffix(this.worldTime.noOfDays)} day"
                                          "\nand ${this.worldTime.noOfWeeks}${getSuffix(this.worldTime.noOfWeeks)} week of the year!"
                                          "\nin ${this.worldTime.url}",
                        textStyle: TextStyle(fontSize: 16),
                      ),

                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),

                      RaisedButton(
                        onPressed: isLoading ? null : getTime,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.refresh),
                            SizedBox(width: 10),
                            Text("Refresh"),
                          ],
                        )
                      ),

                      Expanded(
                        flex: 2,
                        child: SizedBox(),
                      ),

                    ],
                  ),

                  if(isLoading) Center(child: loadingIndicator),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
  
  String getSuffix(date) {
    if(date%10==1) return "st";
    if(date%10==2) return "nd";
    if(date%10==3) return "rd";
    return "th";
  }

  String getDay(day) {
    if(day==1) return "Monday";
    if(day==2) return "Tuesday";
    if(day==3) return "Wednesday";
    if(day==4) return "Thursday";
    if(day==5) return "Friday";
    if(day==6) return "Saturday";
    return "Sunday";
  }

  String getMonth(month) {
    if(month==1) return "January";
    if(month==2) return "February";
    if(month==3) return "March";
    if(month==4) return "April";
    if(month==5) return "May";
    if(month==6) return "June";
    if(month==7) return "July";
    if(month==8) return "August";
    if(month==9) return "September";
    if(month==10) return "October";
    if(month==11) return "November";
    return "December";
  }

  // String getTimeFormated(time) => time<10 ? "0" + time.toString() : time.toString();
  //
  // String getHour(hour) => hour>12 ? (hour-12).toString() : getTimeFormated(hour) ;
  //
  // String getAMorPM(hour) => hour>=12 ? "PM" : "AM";

}