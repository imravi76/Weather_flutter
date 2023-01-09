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
  int _selectedPage = 0;

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
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: CustomColors.dividerLine.withAlpha(150)
            ),
            child: const Center(child: Text("No Alerts!")),
          )
        ],
      );
    } else {
      return Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 10),
            child: const Text("Alerts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
          ),
          alertSwipe(),
        ],
      );
    }
  }

  Widget alertSwipe(){
    return Container(
      height: 325,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomColors.dividerLine.withAlpha(150)
      ),
      child: Row(
        children: [

          Expanded(
            child: PageView(
              scrollDirection: Axis.vertical,
              onPageChanged: (num){
                setState(() {
                  _selectedPage = num;
                });
              },
              children: [
                for(var i=0; i<widget.weatherDataAlert.alert.length; i++)
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                            "Sender Name: ${widget.weatherDataAlert.alert[i].senderName}"
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            "Event: ${widget.weatherDataAlert.alert[i].event}"
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            "Start: ${getDay(widget.weatherDataAlert.alert[i].start)}"
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                            "End: ${getDay(widget.weatherDataAlert.alert[i].end)}"
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 10, right: 20, bottom: 5),
                        child: Text(
                          "Description: ${widget.weatherDataAlert.alert[i].description}", textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 15,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(var i=0; i<widget.weatherDataAlert.alert.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  width: 10.0,
                  height: _selectedPage == i ? 35.0 : 10.0,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  margin: const EdgeInsets.only(
                      top: 2, right: 10
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String getDay(final timeStamp){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('EEEE').format(time);
    return x;
  }
}
