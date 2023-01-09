import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/model/weather_data_current.dart';

import '../custom_colors.dart';

class CurrentWeather extends StatefulWidget {

  final WeatherDataCurrent weatherDataCurrent;

  const CurrentWeather({Key? key, required this.weatherDataCurrent}) : super(key: key);

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        temperatureAreaWidget(),
        const SizedBox(
          height: 20,
        ),
        weatherDetailsWidget(),
      ],
    );
  }

  Widget temperatureAreaWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
          "assets/weather/${widget.weatherDataCurrent.current.weather![0].icon}.png",
          height: 80, width: 80,
        ),
        Container(
          height: 50, width: 1, color: CustomColors.dividerLine
        ),
        RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "${widget.weatherDataCurrent.current.temp!.toDouble()}°C",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 60,
                  color: CustomColors.textColorBlack
                )
              ),
              TextSpan(
                text: "${widget.weatherDataCurrent.current.weather![0].description}",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Colors.grey,
                )
              )
            ]))
      ],
    );

  }

  Widget weatherDetailsWidget(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Image.asset("assets/icons/feelslike.png"),
                  const Text("Feels Like", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(
                    "${widget.weatherDataCurrent.current.feelsLike}°C",
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Image.asset("assets/icons/humidity.png"),
                  const Text("Humidity", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(
                    "${widget.weatherDataCurrent.current.humidity} %",
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Image.asset("assets/icons/clouds.png"),
                  const Text("Clouds", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(
                    "${widget.weatherDataCurrent.current.clouds} %",
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ExpansionTile(title: const Text("Details"),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/icons/sunrise.png"),
                    const Text("Sunrise", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                      getTime(widget.weatherDataCurrent.current.sunrise),
                    ),
                  ],
                ),
              ),
              Container(
                //height: 60,
                width: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/icons/sunset.png"),
                    const Text("Sunset", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                      getTime(widget.weatherDataCurrent.current.sunset),
                    ),
                  ],
                ),
              ),
              Container(
                //height: 60,
                width: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/icons/pressure.png"),
                    const Text("Pressure", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                      "${(widget.weatherDataCurrent.current.pressure)} hPa",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                //height: 60,
                width: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/icons/dew-point.png"),
                    const Text("Dew Point", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                      "${widget.weatherDataCurrent.current.dewPoint}",
                    ),
                  ],
                ),
              ),
              Container(
                //height: 60,
                width: 110,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/icons/windspeed.png", height: 64, width: 70,),
                    const Text("Wind Speed", style: TextStyle(fontWeight: FontWeight.bold),),
                    Row(
                      children: [
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(widget.weatherDataCurrent.current.windDeg! / 360),
                          child: Image.asset("assets/icons/wind-direction.png", width: 20, height: 20,),
                        ),
                        Text(
                          "${widget.weatherDataCurrent.current.windSpeed} Km/h",
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                //height: 60,
                width: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColors.cardColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Image.asset("assets/icons/visibility.png"),
                    const Text("Visibility", style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(
                      "${(widget.weatherDataCurrent.current.visibility)!/1000} Km",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          )
        ],),

      ],
    );

  }
}

String getTime(final timestamp){
  DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  String x = DateFormat('jm').format(time);
  return x;
}
