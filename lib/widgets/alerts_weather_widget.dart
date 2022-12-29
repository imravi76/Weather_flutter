import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../custom_colors.dart';
import '../model/alert.dart';

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
            margin: const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
            child: const Text("Alerts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          alertList()
        ],
      );
    }
  }

  Widget alertList(){
    return Container(
      height: 240,
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          itemCount: widget.weatherDataAlert.alert.length,
          itemBuilder: (context, index){
            return Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
                width: 90,
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0.5, 0),
                          blurRadius: 30,
                          spreadRadius: 1,
                          color: CustomColors.dividerLine.withAlpha(150)
                      )
                    ],
                    color: CustomColors.dividerLine.withAlpha(150)
                ),
                child: AlertDetails(
                  index: index,
                  senderName: widget.weatherDataAlert.alert[index].senderName,
                  event: widget.weatherDataAlert.alert[index].event,
                  start: widget.weatherDataAlert.alert[index].start,
                  end: widget.weatherDataAlert.alert[index].end,
                  description: widget.weatherDataAlert.alert[index].description,
                ),
            );
          }
      ),
    );

  }
}

class AlertDetails extends StatelessWidget {

  int? index;
  String? senderName, event, description;
  int? start, end;

  AlertDetails({Key? key, required this.index, required this.senderName, required this.event, required this.description, required this.start, required this.end}) : super(key: key);

  String getDay(final timeStamp){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('EEEE').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
                "Sender Name: ${senderName}"
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
                "Event: ${event}"
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
                "Start: ${getDay(start)}"
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
                "End: ${getDay(end)}"
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.only(left: 20),
            child: Text(
                "Description: ${description}", textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}

