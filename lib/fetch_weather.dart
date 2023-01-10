import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/alert.dart';
import 'model/weather_data.dart';
import 'model/weather_data_current.dart';
import 'package:http/http.dart' as http;
import 'model/weather_data_daily.dart';
import 'model/weather_data_hourly.dart';

class FetchWeatherAPI{

  String apiKey = "111e76f07e2c48a7d42b3fedbf8f9f4f";
  WeatherData? weatherData;

  final storage = LocalStorage('weather_data.json');

  Future<WeatherData> processData(lat, lon) async{

    var weatherData = await getWeatherFromCache(lat, lon);

    if(weatherData == null){
      return getDataFromAPI(lat, lon);
    }

    /*Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File('$appDocPath/1.json');*/

    /*file.writeAsString(response.body);
    print("Write Successful");*/

    return weatherData;
  }

  Future<WeatherData?> getWeatherFromCache(lat, lon) async {

    await storage.ready;
    var data = storage.getItem('weather_data');

    if (data == null) {
      return null;
    } else {

      Map<String, dynamic> dataNew = data;

      weatherData = WeatherData(WeatherDataCurrent.fromJson(dataNew),
          WeatherDataHourly.fromJson(dataNew),
          WeatherDataDaily.fromJson(dataNew),
          WeatherDataAlert.fromJson(dataNew));

      //getDataFromAPI(lat, lon);
    }
    //weatherData?.fromCache = true; //to indicate post is pulled from cache
    return weatherData!;

  }

  Future<WeatherData> getDataFromAPI(lat, lon) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var units = prefs.getString('units');

    var response = await http.get(Uri.parse(apiURL(lat, lon, apiKey, units)));
    var jsonString = jsonDecode(response.body);

    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString),
        WeatherDataAlert.fromJson(jsonString));

    saveWeather(jsonString!);

    return weatherData!;
  }

  void saveWeather(jsonString) async {
    await storage.ready;
    storage.setItem("weather_data", jsonString);
  }

}

String apiURL(var lat, var lon, var apiKey, units){
  String url;

  url = "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$apiKey&units=$units&exclude=minutely";
  return url;
}
