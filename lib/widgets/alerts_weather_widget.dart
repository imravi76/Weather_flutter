import 'package:flutter/material.dart';
import '../model/alert.dart';
import 'alert_swipe.dart';

class AlertsWeather extends StatefulWidget {

  final WeatherDataAlert weatherDataAlert;

  const AlertsWeather({Key? key, required this.weatherDataAlert}) : super(key: key);

  @override
  State<AlertsWeather> createState() => _AlertsWeatherState();
}

class _AlertsWeatherState extends State<AlertsWeather> {
  
  int lengthList = 0;

  @override
  Widget build(BuildContext context) {
    lengthList = widget.weatherDataAlert.alert.length;
    if(lengthList == 0){
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
            child: const Text("Alerts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(
            height: 40,
            child: Text("No Alerts!"),
          )
        ],
      );
    } else{
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 10),
            child: const Text("Alerts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          AlertSwipe(alertList: widget.weatherDataAlert.alert),
        ],
      );
    }
  }
}
