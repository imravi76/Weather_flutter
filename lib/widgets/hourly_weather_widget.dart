import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/custom_colors.dart';
import '../model/weather_data_hourly.dart';

class HourlyWeather extends StatefulWidget {

  final WeatherDataHourly weatherDataHourly;

  const HourlyWeather({Key? key, required this.weatherDataHourly}) : super(key: key);

  @override
  State<HourlyWeather> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {

  RxInt cardIndex = GlobalController().getIndex();

  //double height = 160;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topLeft,
          child: const Text("Hourly Forecast", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        ),
        hourlyList(),
        hourlyFullDetails(),
      ],
    );
  }

  Widget hourlyList(){
    return Container(
      height: 160,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
          itemCount: widget.weatherDataHourly.hourly.length,
          itemBuilder: (context, index){
          return Obx((() => GestureDetector(
            onTap: (){
              setState(() {
                cardIndex.value = index;
              });
            },
            child: Container(
              width: 90,
              margin: const EdgeInsets.only(left: 20, right: 5),
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
                gradient: cardIndex.value == index ? const LinearGradient(colors: [
                  CustomColors.firstGradientColor,
                  CustomColors.secondGradientColor
                ]) : null
              ),
              child: HourlyDetails(
                index: index,
                cardIndex: cardIndex.toInt(),
                temp: widget.weatherDataHourly.hourly[index].temp!,
                timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                weatherIcon: widget.weatherDataHourly.hourly[index].weather![0].icon!,
              ),
            ),
          )));
          }
      ),
    );
  }

  Widget hourlyFullDetails(){
    return ExpansionTile(title: const Text("More Details"),
    children: [
      Container(
          height: 300,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.only(left: 20),
          child: Column(
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
                    child: Image.asset("assets/icons/feelslike.png"),
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
                      "${widget.weatherDataHourly.hourly[cardIndex.toInt()].feelsLike}°C",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20, width: 60,
                    child: Text(
                      "${widget.weatherDataHourly.hourly[cardIndex.toInt()].pressure} hPa",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20, width: 60,
                    child: Text(
                      "${widget.weatherDataHourly.hourly[cardIndex.toInt()].humidity} %",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20, width: 60,
                    child: Text(
                      "${widget.weatherDataHourly.hourly[cardIndex.toInt()].clouds} %",
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
                    child: Image.asset("assets/icons/windsock.png"),
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
                      "${widget.weatherDataHourly.hourly[cardIndex.toInt()].dewPoint} °C Td",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20, width: 60,
                    child: Text(
                      "${widget.weatherDataHourly.hourly[cardIndex.toInt()].windSpeed} Km/h",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20, width: 60,
                    child: Text(
                      "${widget.weatherDataHourly.hourly[cardIndex.toInt()].windDeg}",
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
                    child: Image.asset("assets/icons/rain.png"),
                  ),
                  Container(
                    height: 60,
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
                    height: 20, width: 60,
                    child: Text(
                      "${widget.weatherDataHourly.hourly[cardIndex.toInt()].pop} %",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 20, width: 60,
                    child: Text(
                      "${(widget.weatherDataHourly.hourly[cardIndex.toInt()].visibility)!/1000} Km",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ],
          )
      )
    ],);
  }
}

class HourlyDetails extends StatelessWidget {

  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;

  HourlyDetails({Key? key, required this.temp, required this.index, required this.cardIndex, required this.timeStamp, required this.weatherIcon}) : super(key: key);

  String getTime(final timeStamp){
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text("$temp°C",
          style: TextStyle(
            color: cardIndex == index ? Colors.white : CustomColors.textColorBlack,
          ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          child: Image.asset(
            "assets/weather/$weatherIcon.png",
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(getTime(timeStamp),
          style: TextStyle(
            color: cardIndex == index ? Colors.white : CustomColors.textColorBlack,
          ),
          ),
        ),
      ],
    );
  }
}

