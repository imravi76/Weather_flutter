import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:flutter_weather_bg_null_safety/utils/weather_type.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
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

  WeatherType weatherType = WeatherType.sunny;

  String day = "";

  @override
  void initState() {
    super.initState();
    var hour = DateTime.now().hour;
    if(hour<18 && hour>6){
      day = "Day";
    } else{
      day = "Night";
    }
  }

  @override
  Widget build(BuildContext context) {
    timer();

    if(globalController.getData() == null){
      //newTimer();
      switch(globalController.getData().getCurrentWeather().current.weather?[0].main){

        case "Clear":
          switch(day){
            case "Day":
              weatherType = WeatherType.sunny;
              break;
            case "Night":
              weatherType = WeatherType.sunnyNight;
              break;
            default:
              weatherType = WeatherType.sunny;
              break;
          }
          break;

        case "Clouds":
          switch(day){
            case "Day":
              weatherType = WeatherType.cloudy;
              break;
            case "Night":
              weatherType = WeatherType.cloudyNight;
              break;
            default:
              weatherType = WeatherType.cloudy;
              break;
          }
          break;

        case "Snow":
          switch(globalController.getData().getCurrentWeather().current.weather?[0].description){
            case "light snow":
              weatherType = WeatherType.lightSnow;
              break;
            case "Snow":
              weatherType = WeatherType.middleSnow;
              break;
            case "Heavy snow":
              weatherType = WeatherType.heavySnow;
              break;
            default:
              weatherType = WeatherType.lightSnow;
              break;
          }
          break;

        case "Rain":
          switch(globalController.getData().getCurrentWeather().current.weather?[0].description){
            case "light rain":
              weatherType = WeatherType.lightRainy;
              break;
            case "moderate rain":
              weatherType = WeatherType.middleRainy;
              break;
            case "heavy intensity rain":
              weatherType = WeatherType.heavyRainy;
              break;
            default:
              weatherType = WeatherType.lightRainy;
              break;
          }
          break;

        case "Drizzle":
          weatherType = WeatherType.lightRainy;
          break;

        case "Thunderstorm":
          weatherType = WeatherType.thunder;
          break;

        case "Haze":
          weatherType = WeatherType.hazy;
          break;

        case "Dust":
          weatherType = WeatherType.dusty;
          break;

        case "Fog":
          weatherType = WeatherType.foggy;
          break;

        default:
          weatherType = WeatherType.sunny;
      }
    }

    return Scaffold(
      body: LiquidPullToRefresh(
        animSpeedFactor: 5.0,
        color: CustomColors.dividerLine,
        showChildOpacityTransition: true,
        onRefresh: () => globalController.getRefresh(),
        child: SafeArea(
          child: Obx(() => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                child: Stack(
                  children: [
                    WeatherBg(
                      width: MediaQuery.of(context).size.width,
                      weatherType: weatherType,
                      height: MediaQuery.of(context).size.height,
                    ),
                    ListView(
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
                  ],
                ),
              )),
        ),
      ),
    );
  }

  void timer() {
    Timer(
        const Duration(seconds: 3),(){
      globalController.getRefresh();
      setState(() {

      });
    }
    );
  }
}
