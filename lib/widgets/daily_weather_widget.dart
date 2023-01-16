import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  String tempUnit = '';
  String windUnit = '';

  @override
  void initState() {
    super.initState();
    getUnit();
  }

  void getUnit() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? units = prefs.getString('units');

    if(units == 'metric'){
      tempUnit = '°C';
      windUnit = 'm/s';
    }else if(units == 'imperial'){
      tempUnit = '°F';
      windUnit = 'mi/h';
    }else{
      tempUnit = '°K';
      windUnit = 'm/s';
    }

    setState(() {

    });
  }

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
                      containerHeight = 880;
                      listHeight = 820;
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
                trailing: Text("${widget.weatherDataDaily.daily[index].temp!.max}$tempUnit/${widget.weatherDataDaily.daily[index].temp!.min}$tempUnit"),
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/sunrise.png"),
                          ),
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/sunset.png"),
                          ),
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/moonrise.png"),
                          ),
                          Container(
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
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Sunrise", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  getTime(widget.weatherDataDaily.daily[index].sunrise),
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Sunset", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  getTime(widget.weatherDataDaily.daily[index].sunset),
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Moonrise", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  getTime(widget.weatherDataDaily.daily[index].moonrise),
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Moonset", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  getTime(widget.weatherDataDaily.daily[index].moonset),
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/humidity.png"),
                          ),
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/pressure.png"),
                          ),
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/clouds.png"),
                          ),
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/dew-point.png"),
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
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Humidity", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "${widget.weatherDataDaily.daily[index].humidity} %",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Pressure", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "${widget.weatherDataDaily.daily[index].pressure} hPa",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Clouds", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "${widget.weatherDataDaily.daily[index].clouds} %",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 65,
                            child: Column(
                              children: [
                                const Text("Dew Point", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "${widget.weatherDataDaily.daily[index].dewPoint}$tempUnit",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/windspeed.png"),
                          ),

                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/pop.png"),
                          ),
                          if(widget.weatherDataDaily.daily[index].rain != null) Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/rain.png"),
                          ),
                          if(widget.weatherDataDaily.daily[index].snow != null) Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/snow.png"),
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
                            width: 80,
                            child: Column(
                              children: [
                                const Text("Wind", style: TextStyle(fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    RotationTransition(
                                      turns: AlwaysStoppedAnimation(widget.weatherDataDaily.daily[index].windDeg! / 360),
                                      child: Image.asset("assets/icons/wind-direction.png", width: 20,),
                                    ),
                                    Text(
                                      " ${widget.weatherDataDaily.daily[index].windSpeed}$windUnit",
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text("POP", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "${(widget.weatherDataDaily.daily[index].pop!)*100} %",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          if(widget.weatherDataDaily.daily[index].rain != null) SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Rain", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "${(widget.weatherDataDaily.daily[index].rain)} mm",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          if(widget.weatherDataDaily.daily[index].snow != null) SizedBox(
                            width: 60,
                            child: Column(
                              children: [
                                const Text("Snow", style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(
                                  "${(widget.weatherDataDaily.daily[index].snow)} mm",
                                  style: const TextStyle(fontSize: 12),
                                  textAlign: TextAlign.center,
                                ),
                              ],
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
