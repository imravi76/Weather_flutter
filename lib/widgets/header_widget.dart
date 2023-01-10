import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/model/weather_data_current.dart';

import '../custom_colors.dart';

class Header extends StatefulWidget {
  final WeatherDataCurrent weatherDataCurrent;

  const Header({Key? key, required this.weatherDataCurrent}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  String City = "";
  String Country = "";

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

    List<Placemark> placemark = await placemarkFromCoordinates(lat!, lon!);
    Placemark place = placemark[0];
    setState(() {
      City = place.locality!;
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
              margin: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.topLeft,
              child: Text(
                City,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  letterSpacing: 1.2,
                  color: Color(0xFF17262A),
                ),
              ),
            ),
            globalController.checkConnection() == true
                ? Container(
                    margin: const EdgeInsets.only(right: 20),
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.greenAccent),
                  )
                : Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Row(
                      children: const [
                        Icon(Icons.cloud_off),
                        SizedBox(width: 5),
                        Text("Offline Mode")
                      ],
                    ),
                  )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
              margin: const EdgeInsets.only(right: 20, bottom: 20),
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
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(68),
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0),
              ]),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xff87A0E5).withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Temperature",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/icons/temperature.png",
                                      width: 28, height: 28),
                                  Text(
                                    "${widget.weatherDataCurrent.current.temp!.toDouble()}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, bottom: 3),
                                    child: Text(
                                      '°C',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: -0.2,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 48,
                            width: 2,
                            decoration: BoxDecoration(
                              color: const Color(0xffF56E98).withOpacity(0.5),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                "Feels Like",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  letterSpacing: -0.1,
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/icons/feelslike.png",
                                    width: 28,
                                    height: 28,
                                  ),
                                  Text(
                                    "${widget.weatherDataCurrent.current.feelsLike}",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 3),
                                    child: Text(
                                      '°C',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        letterSpacing: -0.2,
                                        color: Colors.grey.withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, top: 8, bottom: 8),
                child: Container(
                  height: 2,
                  decoration: const BoxDecoration(
                    color: CustomColors.dividerLine,
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/humidity.png",
                            width: 30,
                            height: 30,
                          ),
                          const Text(
                            "Humidity",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Container(
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
                              width: (widget
                                      .weatherDataCurrent.current.humidity!
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
                      Text(
                        "${widget.weatherDataCurrent.current.humidity} %",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/clouds.png",
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            "Clouds",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 4,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffF56E98).withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: (widget.weatherDataCurrent.current.clouds!
                                      .toDouble()) /
                                  2,
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xffF56E98).withOpacity(0.1),
                                  Color(0xffF56E98),
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${widget.weatherDataCurrent.current.clouds} %",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/uvi.png",
                            width: 30,
                            height: 30,
                          ),
                          Text(
                            "Uvi",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: -0.2,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 4,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xffF1B440).withOpacity(0.2),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: (widget.weatherDataCurrent.current.uvi!
                                      .toDouble()) *
                                  5,
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color(0xffF1B440).withOpacity(0.1),
                                  Color(0xffF1B440),
                                ]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "${widget.weatherDataCurrent.current.uvi}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
