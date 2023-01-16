import 'package:weather/model/rain.dart';
import 'package:weather/model/snow.dart';
import 'package:weather/model/weather.dart';

class WeatherDataHourly{
  List<Hourly> hourly;
  WeatherDataHourly({required this.hourly});

  factory WeatherDataHourly.fromJson(Map<String, dynamic> json) =>
      WeatherDataHourly(hourly:
      List<Hourly>.from(json['hourly'].map((e) => Hourly.fromJson(e))));
}

class Hourly {
  int? dt;
  int? temp;
  double? feelsLike;
  int? pressure;
  int? humidity;
  double? dewPoint;
  int? clouds;
  int? visibility;
  double? windSpeed;
  int? windDeg;
  List<Weather>? weather;
  double? pop;
  List<Rain>? rain;
  List<Snow>? snow;

  Hourly({
    this.dt,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.pop,
    this.rain,
    this.snow
  });

  factory Hourly.fromJson(Map<String, dynamic> json) => Hourly(
    dt: json['dt'] as int?,
    temp: (json['temp'] as num?)?.round(),
    feelsLike: (json['feels_like'] as num?)?.toDouble(),
    pressure: json['pressure'] as int?,
    humidity: json['humidity'] as int?,
    dewPoint: (json['dew_point'] as num?)?.toDouble(),
    clouds: json['clouds'] as int?,
    visibility: json['visibility'] as int?,
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    windDeg: json['wind_deg'] as int?,
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    pop: (json['pop'] as num?)?.toDouble(),
    rain: (json['rain'] as List<dynamic>?)
        ?.map((e) => Rain.fromJson(e as Map<String, dynamic>))
        .toList(),
    snow: (json['snow'] as List<dynamic>?)
        ?.map((e) => Snow.fromJson(e as Map<String, dynamic>))
        .toList()
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'temp': temp,
    'feels_like': feelsLike,
    'pressure': pressure,
    'humidity': humidity,
    'dew_point': dewPoint,
    'clouds': clouds,
    'visibility': visibility,
    'wind_speed': windSpeed,
    'wind_deg': windDeg,
    'weather': weather?.map((e) => e.toJson()).toList(),
    'pop': pop,
    'rain': rain?.map((e) => e.toJson()).toList(),
    'snow': snow?.map((e) => e.toJson()).toList(),
  };
}
