import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/custom_colors.dart';
import '../model/weather_data_hourly.dart';

class HourlyWeather extends StatefulWidget {
  final WeatherDataHourly weatherDataHourly;

  const HourlyWeather({Key? key, required this.weatherDataHourly})
      : super(key: key);

  @override
  State<HourlyWeather> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeather> {
  RxInt cardIndex = GlobalController().getIndex();

  var selectedItemPosition = -1;
  bool detailsStatus = false;

  String tempUnit = '';
  String windUnit = '';

  @override
  void initState() {
    if(selectedItemPosition == -1){
      detailsStatus = false;
    }
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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20),
          alignment: Alignment.topLeft,
          child: const Text(
            "Hourly Forecast",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        hourlyList(),
        hourlyFullDetailsNew()
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      //color: Colors.transparent,
      height: 250,
      margin: const EdgeInsets.only(left: 5),
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.weatherDataHourly.hourly.length,
          itemBuilder: (context, index) {
            return Obx((() => GestureDetector(
                  onTap: () {
                    setState(() {
                      cardIndex.value = index;
                      if(selectedItemPosition == -1){
                        selectedItemPosition = index;
                        detailsStatus = true;
                      }else if(selectedItemPosition == index){
                        selectedItemPosition = -1;
                        detailsStatus = false;
                        cardIndex.value = 0;
                      } else{
                        selectedItemPosition = index;
                        detailsStatus = true;
                      }
                    });
                  },
                  child: HourlyDetailsNew(
                    index: index,
                    cardIndex: cardIndex.toInt(),
                    temp: widget.weatherDataHourly.hourly[index].temp!,
                    timeStamp: widget.weatherDataHourly.hourly[index].dt!,
                    weatherIcon: widget
                        .weatherDataHourly.hourly[index].weather![0].icon!,
                    description: widget.weatherDataHourly.hourly[index]
                        .weather![0].description!, firstHour: true,
                    tempUnit: tempUnit,
                  ),
                )));
          }),
    );
  }

  Widget hourlyFullDetailsNew(){
    return Visibility(
      visible: detailsStatus,
        child: ExpansionTile(
          title: const Text(''),
          initiallyExpanded: true,
          trailing: const SizedBox.shrink(),
          children: [
            Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.only(left: 20, bottom: 10),
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
                          child: Image.asset("assets/icons/feelslike.png"),
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
                          child: Image.asset("assets/icons/humidity.png"),
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
                              const Text(
                                "Feels Like",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${widget.weatherDataHourly.hourly[cardIndex.toInt()].feelsLike}$tempUnit",
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
                              const Text(
                                "Pressure",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${widget.weatherDataHourly.hourly[cardIndex.toInt()].pressure} hPa",
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
                              const Text(
                                "Humidity",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${widget.weatherDataHourly.hourly[cardIndex.toInt()].humidity} %",
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
                              const Text(
                                "Clouds",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${widget.weatherDataHourly.hourly[cardIndex.toInt()].clouds} %",
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
                          child: Image.asset("assets/icons/pop.png"),
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
                              const Text(
                                "Dew Point",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${widget.weatherDataHourly.hourly[cardIndex.toInt()].dewPoint}$tempUnit",
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
                                const Text(
                                  "Wind Speed",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    RotationTransition(
                                      turns: AlwaysStoppedAnimation(widget
                                          .weatherDataHourly
                                          .hourly[cardIndex.toInt()]
                                          .windDeg! /
                                          360),
                                      child: Image.asset(
                                        "assets/icons/wind-direction.png",
                                        width: 20,
                                        height: 20,
                                      ),
                                    ),
                                    Text(
                                      " ${widget.weatherDataHourly.hourly[cardIndex.toInt()].windSpeed}$windUnit",
                                      style: const TextStyle(fontSize: 12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(
                          width: 65,
                          child: Column(
                            children: [
                              const Text(
                                "POP",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${(widget.weatherDataHourly.hourly[cardIndex.toInt()].pop!)*100} %",
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
                              const Text(
                                "Visibility",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${(widget.weatherDataHourly.hourly[cardIndex.toInt()].visibility)! / 1000} Km",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if(widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null || widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null)
                      const SizedBox(height: 15,),
                    if(widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null || widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null)
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                      if(widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null)
                          Container(
                            width: 60,
                            margin: const EdgeInsets.only(left: 15),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/rain.png"),
                          ),
                          if(widget.weatherDataHourly.hourly[cardIndex.toInt()].snow != null)
                          Container(
                            width: 60,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(left: 35),
                            decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Image.asset("assets/icons/snow.png"),
                          ),
                        ],
                      ),
                    if(widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null || widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null)
                    const SizedBox(
                      height: 10,
                    ),
                    if(widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null || widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null)
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if(widget.weatherDataHourly.hourly[cardIndex.toInt()].rain != null)
                        Container(
                          margin: const EdgeInsets.only(left: 12),
                          width: 65,
                          child: Column(
                            children: [
                              const Text(
                                "Rain",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${widget.weatherDataHourly.hourly[cardIndex.toInt()].rain?[0].ih} mm",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        if(widget.weatherDataHourly.hourly[cardIndex.toInt()].snow != null)
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          width: 65,
                          child: Column(
                            children: [
                              const Text(
                                "Snow",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${(widget.weatherDataHourly.hourly[cardIndex.toInt()].snow?[0].ih)} mm",
                                style: const TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        )
    );
  }
}

class HourlyDetailsNew extends StatelessWidget {
  int temp;
  int index;
  int cardIndex;
  int timeStamp;
  String weatherIcon;
  String description;
  bool firstHour;
  String tempUnit;

  List colorBg = const [Color(0xffFF5287), Color(0xffFFB295), Color(0xff5C5EDD)];
  List colorFg = const [Color(0xffFE95B6), Color(0xffFA7D82), Color(0xff738AE6)];

  HourlyDetailsNew(
      {Key? key,
      required this.temp,
      required this.index,
      required this.cardIndex,
      required this.timeStamp,
      required this.weatherIcon,
      required this.description,
      required this.firstHour, required this.tempUnit})
      : super(key: key);

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    String times = x.replaceAll(RegExp('[^0-9 :]'), '');
    return times;
  }

  String getTimes(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat('jm').format(time);
    String times = x.replaceAll(RegExp('[^A-Za-z]'), '');
    return times;
  }

  getDescription(String description) {
    String desc = description.replaceAll(' ', '\n');
    return desc;
  }

  @override
  Widget build(BuildContext context) {
    
    if(index == 0){
      firstHour = false;
    }
    return Visibility(
      visible: firstHour,
      child: SizedBox(
          width: 140,
          child: Stack(children: [
            Padding(
                padding:
                    const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
                child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: cardIndex == index
                                ? const Color(0xff1E1466).withOpacity(0.6)
                                : colorBg[index % colorBg.length],
                            offset: const Offset(1.1, 4.0),
                            blurRadius: 8.0),
                      ],
                      gradient: LinearGradient(
                        colors: cardIndex == index
                            ? const <Color>[
                                Color(0xff6F72CA),
                                Color(0xff1E1466),
                              ]
                            : <Color>[
                          colorFg[index % colorFg.length],
                          colorBg[index % colorBg.length],
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(54.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 54, left: 16, right: 16, bottom: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$temp$tempUnit",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 0.2,
                              color: Colors.white,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    getDescription(description),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      letterSpacing: 0.2,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                getTime(timeStamp),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                  letterSpacing: 0.2,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 4, bottom: 3),
                                child: Text(
                                  getTimes(timeStamp),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 10,
                                    letterSpacing: 0.2,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))),
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAFAFA).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: 15,
              left: 10,
              child: SizedBox(
                width: 60,
                height: 60,
                child: Image.asset("assets/weather/$weatherIcon.png"),
              ),
            )
          ])),
    );
  }
}
