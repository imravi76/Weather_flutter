import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../custom_colors.dart';
import '../model/weather_data_daily.dart';

class DailyWeather extends StatefulWidget {

  final WeatherDataDaily weatherDataDaily;

  const DailyWeather({Key? key, required this.weatherDataDaily}) : super(key: key);

  @override
  State<DailyWeather> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeather> {
  String getDay(final day){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat('EEE').format(time);
    return x;
  }

  String getTime(final timestamp){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  double containerHeight = 400;
  double listHeight = 300;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerHeight,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10),
            child: const Text(
              "Daily Forecast",
              style: TextStyle(
                color: CustomColors.textColorBlack, fontSize: 17, fontWeight: FontWeight.bold
              ),
            ),
          ),

          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList(){
    return SizedBox(
      height: listHeight,
      child: ListView.builder(
        itemCount: widget.weatherDataDaily.daily.length,
          itemBuilder: (context, index){
          return Column(
          children: [
            Container(
              //height: 60,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ExpansionTile(
                onExpansionChanged: (value){
                  if(value){
                    setState(() {
                      containerHeight = 830;
                      listHeight = 770;
                    });
                  } else{
                    setState(() {
                      containerHeight = 400;
                      listHeight = 300;
                    });
                  }
                },
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                leading: SizedBox(
                  width: 30,
                  child: Text(
                    getDay(widget.weatherDataDaily.daily[index].dt),
                    style: const TextStyle(
                      color: CustomColors.textColorBlack, fontSize: 13,
                    ),
                  ),
                ),
                title: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset("assets/weather/${widget.weatherDataDaily.daily[index].weather![0].icon}.png"),
                ),
                trailing: Text("${widget.weatherDataDaily.daily[index].temp!.max}°C/${widget.weatherDataDaily.daily[index].temp!.min}°C"),
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/sunrise.png"),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/sunset.png"),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/moonrise.png"),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/moonset.png"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              getTime(widget.weatherDataDaily.daily[index].sunrise),
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              getTime(widget.weatherDataDaily.daily[index].sunset),
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              getTime(widget.weatherDataDaily.daily[index].moonset),
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              getTime(widget.weatherDataDaily.daily[index].moonrise),
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/moon-phase.png",
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/humidity.png"),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/pressure.png"),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/clouds.png"),
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              "${widget.weatherDataDaily.daily[index].moonPhase}",
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              "${widget.weatherDataDaily.daily[index].humidity} %",
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              "${widget.weatherDataDaily.daily[index].pressure} hPa",
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              "${widget.weatherDataDaily.daily[index].clouds} %",
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/dew-point.png"),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/windspeed.png"),
                          ),

                          Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/rain.png"),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              "${widget.weatherDataDaily.daily[index].dewPoint}°C Td",
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 20, width: 80,
                            child: Row(
                              children: [
                                RotationTransition(
                                  turns: AlwaysStoppedAnimation(widget.weatherDataDaily.daily[index].windDeg! / 360),
                                  child: Image.asset("assets/icons/wind-direction.png"),
                                ),
                                Text(
                                  "${widget.weatherDataDaily.daily[index].windSpeed} Km/h",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: 20, width: 60,
                            child: Text(
                              "${widget.weatherDataDaily.daily[index].pop} %",
                              style: const TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  )
                ],
              ),
          ),

            Container(
              height: 1,
              color: CustomColors.dividerLine,
            ),
          ],
          );
    }),
    );
  }
}
