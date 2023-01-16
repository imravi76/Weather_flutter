import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/model/weather_data_current.dart';

import '../custom_colors.dart';

class CurrentWeather extends StatefulWidget {

  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeather({Key? key, required this.weatherDataCurrent}) : super(key: key);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {

  String dewUnit = '';
  String windUnit = '';

  @override
  void initState(){
    super.initState();
    getUnits();
  }

  void getUnits() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? units = prefs.getString('units');

    if(units == 'metric'){
      dewUnit = '°C';
      windUnit = 'm/s';
    }else if(units == 'imperial'){
      dewUnit = '°F';
      windUnit = 'mi/h';
    } else{
      dewUnit = '°K';
      windUnit = 'm/s';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(title: const Text("Details"),
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
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
                          child: Image.asset("assets/icons/pressure.png"),
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
                          width: 65,
                          child: Column(
                            children: [
                              const Text("Sunrise", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                getTime(widget.weatherDataCurrent.current.sunrise),
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
                              const Text("Sunset", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                getTime(widget.weatherDataCurrent.current.sunset),
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
                              const Text("Pressure", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                "${widget.weatherDataCurrent.current.pressure} hPa",
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
                          child: Image.asset("assets/icons/dew-point.png"),
                        ),
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
                          child: Image.asset("assets/icons/visibility.png"),
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
                          width: 65,
                          child: Column(
                            children: [
                              const Text("Dew Point", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                "${widget.weatherDataCurrent.current.dewPoint}$dewUnit",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 80,
                            child: Column(
                              children: [
                                const Text("Wind Speed", style: TextStyle(fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    RotationTransition(
                                      turns: AlwaysStoppedAnimation(widget.weatherDataCurrent.current.windDeg! / 360),
                                      child: Image.asset("assets/icons/wind-direction.png", width: 20, height: 20,),
                                    ),
                                    Text(
                                      " ${widget.weatherDataCurrent.current.windSpeed}$windUnit",
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
                        SizedBox(
                          width: 65,
                          child: Column(
                            children: [
                              const Text("Visibility", style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(
                                "${(widget.weatherDataCurrent.current.visibility)!/1000} Km",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            )
          ],
        ),
      ],
    );
  }
}

String getTime(final timestamp){
  DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String x = DateFormat('jm').format(time);
  return x;
}
