import 'dart:convert';
import 'model/alert.dart';
import 'model/weather_data.dart';
import 'model/weather_data_current.dart';
import 'package:http/http.dart' as http;
import 'model/weather_data_daily.dart';
import 'model/weather_data_hourly.dart';

class FetchWeatherAPI{

  String apiKey = "111e76f07e2c48a7d42b3fedbf8f9f4f";
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async{

    var response = await http.get(Uri.parse(apiURL(lat, lon, apiKey)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
    WeatherDataDaily.fromJson(jsonString),
    WeatherDataAlert.fromJson(jsonString));

    return weatherData!;
  }
}

String apiURL(var lat, var lon, var apiKey){
  String url;

  url = "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=metric&exclude=minutely";
  return url;
}