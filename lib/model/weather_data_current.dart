import 'package:weather/model/rain.dart';
import 'package:weather/model/snow.dart';

import 'weather.dart';

class WeatherDataCurrent{
  final Current current;
  WeatherDataCurrent({required this.current});

  factory WeatherDataCurrent.fromJson(Map<String, dynamic> json) =>
      WeatherDataCurrent(current: Current.fromJson(json['current']));
}

class Current {
  int? dt;
  int? sunrise;
  int? sunset;
  int? temp;
  double? feelsLike;
  int? humidity;
  int? pressure;
  double? dewPoint;
  int? windDeg;
  int? clouds;
  int? visibility;
  double? windSpeed;
  double? uvi;
  List<Weather>? weather;
  List<Rain>? rain;
  List<Snow>? snow;

  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.humidity,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.weather,
    this.pressure,
    this.dewPoint,
    this.windDeg,
    this.uvi,
    this.rain,
    this.snow
  });

  factory Current.fromJson(Map<String, dynamic> json) => Current(
    dt: json['dt'] as int?,
    sunrise: json['sunrise'] as int?,
    sunset: json['sunset'] as int?,
    temp: (json['temp'] as num?)?.round(),
    feelsLike: (json['feels_like'] as num?)?.toDouble(),
    humidity: json['humidity'] as int?,
    clouds: json['clouds'] as int?,
    visibility: json['visibility'] as int?,
    pressure: json['pressure'] as int?,
    dewPoint: (json['dew_point'] as num?)?.toDouble(),
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    uvi: (json['uvi'] as num?)?.toDouble(),
    windDeg: json['wind_deg'] as int?,
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    rain: (json['rain'] as List<dynamic>?)
      ?.map((e) => Rain.fromJson(e as Map<String, dynamic>))
      .toList(),
    snow: (json['snow'] as List<dynamic>?)
        ?.map((e) => Snow.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'sunrise': sunrise,
    'sunset': sunset,
    'temp': temp,
    'feels_like': feelsLike,
    'humidity': humidity,
    'pressure': pressure,
    'dew_point': dewPoint,
    'clouds': clouds,
    'visibility': visibility,
    'wind_speed': windSpeed,
    'wind_deg': windDeg,
    'uvi':uvi,
    'weather': weather?.map((e) => e.toJson()).toList(),
    'rain': rain?.map((e) => e.toJson()).toList(),
    'snow': snow?.map((e) => e.toJson()).toList()
  };
}
