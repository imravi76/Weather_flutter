import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/custom_colors.dart';

import '../widgets/alerts_weather_widget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/custom_action_bar.dart';
import '../widgets/daily_weather_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_weather_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F8),
      body: RefreshIndicator(
        onRefresh: () => globalController.getRefresh(),
        child: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack(
                children: [
                  Center(
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Header(weatherDataCurrent:
                          globalController.getData().getCurrentWeather(),),
                          CurrentWeather(
                            weatherDataCurrent:
                                globalController.getData().getCurrentWeather(),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          HourlyWeather(
                            weatherDataHourly:
                                globalController.getData().getHourlyWeather(),
                          ),
                          DailyWeather(
                            weatherDataDaily:
                                globalController.getData().getDailyWeather(),
                          ),
                          Container(
                            height: 1,
                            color: CustomColors.dividerLine,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          AlertsWeather(
                            weatherDataAlert:
                                globalController.getData().getAlertWeather(),
                          ),
                        ],
                      ),
                    ),
                  CustomActionBar(cityChild: Container(
                    margin: const EdgeInsets.only(right: 20),
                    //alignment: Alignment.topLeft,
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
                  ), statusChild: globalController.checkConnection() == true
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
                  ),)
                ],
              )),
        ),
      ),
    );
  }
}
