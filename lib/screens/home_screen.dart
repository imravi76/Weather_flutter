import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:weather/controller/global_controller.dart';
import 'package:weather/custom_colors.dart';

import '../widgets/alerts_weather_widget.dart';
import '../widgets/current_weather_widget.dart';
import '../widgets/daily_weather_widget.dart';
import '../widgets/header_widget.dart';
import '../widgets/hourly_weather_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidPullToRefresh(
        color: CustomColors.dividerLine,
        showChildOpacityTransition: true,
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
                      Header(),
                      CurrentWeather(
                        weatherDataCurrent: globalController.getData().getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HourlyWeather(
                        weatherDataHourly: globalController.getData().getHourlyWeather(),
                      ),
                      DailyWeather(
                        weatherDataDaily: globalController.getData().getDailyWeather(),
                      ),
                      Container(
                        height: 1,
                        color: CustomColors.dividerLine,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                     AlertsWeather(
                        weatherDataAlert: globalController.getData().getAlertWeather(),
                      ),
                    ],
                  ),
              )),
        ),
      ),
    );
  }
}
