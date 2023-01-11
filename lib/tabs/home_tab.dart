import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/custom_colors.dart';

import '../widgets/alerts_weather_widget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/daily_weather_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_weather_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  void initState() {
    super.initState();
    timer();
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
              : Center(
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
                )),
        ),
      ),
    );
  }

  void timer() {
    Timer(const Duration(seconds: 2), () {
      globalController.getRefresh();
      setState(() {});
    });
  }
}
