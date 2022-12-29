import 'package:weather/model/weather_data_current.dart';
import 'package:weather/model/weather_data_daily.dart';
import 'package:weather/model/weather_data_hourly.dart';

import 'alert.dart';

class WeatherData{
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  final WeatherDataAlert? alert;

  WeatherData([this.current, this.hourly, this.daily, this.alert]);

  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWeather() => daily!;
  WeatherDataAlert getAlertWeather() => alert!;
}
