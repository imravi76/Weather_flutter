import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/model/weather_data_current.dart';

class Header extends StatefulWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const Header({Key? key, required this.weatherDataCurrent}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String Country = "";
  String tempUnit = "";

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    getAddress();
    super.initState();
  }

  getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double? lat = prefs.getDouble('lat');
    double? lon = prefs.getDouble('lon');
    String? units = prefs.getString('units');

    if(units == 'metric'){
      tempUnit = '°C';
    } else if(units == 'imperial'){
      tempUnit = '°F';
    }else{
      tempUnit = '°K';
    }

    setState(() {

    });

    List<Placemark> placemark = await placemarkFromCoordinates(lat!, lon!);
    Placemark place = placemark[0];
    setState(() {
      Country = "${place.administrativeArea!}, ${place.country!}";
    });
  }

  String getTime(final timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('jm').format(time);
    return x;
  }

  String getDay(final timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    String x = DateFormat('E').format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
              alignment: Alignment.topLeft,
              child: Text(
                Country,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  letterSpacing: 0.5,
                  color: Color(0xFF4A6572),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 20, bottom: 20, top: 40),
              alignment: Alignment.topLeft,
              child: Text(
                "Updated: ${getDay(widget.weatherDataCurrent.current.dt)}, ${getTime(widget.weatherDataCurrent.current.dt)}",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 13,
                  letterSpacing: 0.5,
                  color: Color(0xFF2633C5),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding:
              const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 18),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                  topRight: Radius.circular(68.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ],
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 4),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 48,
                                    width: 2,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff87A0E5).withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 2),
                                          child: Text(
                                            'Temperature',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.1,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 28,
                                              height: 28,
                                              child: Image.asset(
                                                  "assets/icons/temperature.png"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                "${widget.weatherDataCurrent.current.temp!.toDouble()}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Color(0xFF17262A),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                tempUnit,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  letterSpacing: -0.2,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: 48,
                                    width: 2,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF56E98).withOpacity(0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 4, bottom: 2),
                                          child: Text(
                                            'Feels Like',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              letterSpacing: -0.1,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: <Widget>[
                                            SizedBox(
                                              width: 28,
                                              height: 28,
                                              child: Image.asset(
                                                  "assets/icons/feelslike.png"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4, bottom: 3),
                                              child: Text(
                                                "${widget.weatherDataCurrent.current.feelsLike}",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16,
                                                  color: Color(0xFF17262A),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, bottom: 3),
                                              child: Text(
                                                tempUnit,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  letterSpacing: -0.2,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset(
                            "assets/weather/${widget.weatherDataCurrent.current.weather![0].icon}.png",
                            height: 80,
                            width: 80,
                          ),
                          Text(
                              "${widget.weatherDataCurrent.current.weather![0].description}"),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 8, bottom: 8),
                  child: Container(
                    height: 2,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF2F3F8),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 24, right: 24, top: 8, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Humidity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing: -0.2,
                                color: Color(0xFF253840),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Container(
                                height: 4,
                                width: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff87A0E5).withOpacity(0.2),
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(4.0)),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: (widget.weatherDataCurrent.current
                                              .humidity!
                                              .toDouble()) /
                                          2,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          const Color(0xff87A0E5),
                                          const Color(0xff87A0E5).withOpacity(0.5),
                                        ]),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                "${widget.weatherDataCurrent.current.humidity} %",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Clouds',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: Color(0xFF253840),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Container(
                                    height: 4,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF56E98).withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: (widget.weatherDataCurrent
                                                  .current.clouds!
                                                  .toDouble()) /
                                              2,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              const Color(0xffF56E98)
                                                  .withOpacity(0.1),
                                              const Color(0xffF56E98),
                                            ]),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    "${widget.weatherDataCurrent.current.clouds} %",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Text(
                                  'Uvi',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    letterSpacing: -0.2,
                                    color: Color(0xFF253840),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 0, top: 4),
                                  child: Container(
                                    height: 4,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF1B440).withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(4.0)),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: (widget.weatherDataCurrent
                                                  .current.uvi!
                                                  .toDouble()) *
                                              5,
                                          height: 4,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              const Color(0xffF1B440)
                                                  .withOpacity(0.1),
                                              const Color(0xffF1B440),
                                            ]),
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(4.0)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Text(
                                    "${widget.weatherDataCurrent.current.uvi}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
