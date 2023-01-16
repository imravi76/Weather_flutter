import 'temp.dart';
import 'weather.dart';

class WeatherDataDaily{
  List<Daily> daily;
  WeatherDataDaily({required this.daily});

  factory WeatherDataDaily.fromJson(Map<String, dynamic> json) =>
      WeatherDataDaily(daily:
      List<Daily>.from(json['daily'].map((e) => Daily.fromJson(e))));
}

class Daily {
  int? dt;
  int? sunrise;
  int? sunset;
  int? moonrise;
  int? moonset;
  Temp? temp;
  int? pressure;
  int? humidity;
  double? dewPoint;
  double? windSpeed;
  int? windDeg;
  List<Weather>? weather;
  int? clouds;
  double? pop;
  double? rain;
  double? snow;

  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.temp,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    this.snow,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
    dt: json['dt'] as int?,
    sunrise: json['sunrise'] as int?,
    sunset: json['sunset'] as int?,
    moonrise: json['moonrise'] as int?,
    moonset: json['moonset'] as int?,
    temp: json['temp'] == null
        ? null
        : Temp.fromJson(json['temp'] as Map<String, dynamic>),
    pressure: json['pressure'] as int?,
    humidity: json['humidity'] as int?,
    dewPoint: (json['dew_point'] as num?)?.toDouble(),
    windSpeed: (json['wind_speed'] as num?)?.toDouble(),
    windDeg: json['wind_deg'] as int?,
    weather: (json['weather'] as List<dynamic>?)
        ?.map((e) => Weather.fromJson(e as Map<String, dynamic>))
        .toList(),
    clouds: json['clouds'] as int?,
    pop: (json['pop'] as num?)?.toDouble(),
    rain: (json['rain'] as num?)?.toDouble(),
    snow: (json['snow'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'dt': dt,
    'sunrise': sunrise,
    'sunset': sunset,
    'moonrise': moonrise,
    'moonset': moonset,
    'temp': temp?.toJson(),
    'pressure': pressure,
    'humidity': humidity,
    'dew_point': dewPoint,
    'wind_speed': windSpeed,
    'wind_deg': windDeg,
    'weather': weather?.map((e) => e.toJson()).toList(),
    'clouds': clouds,
    'pop': pop,
    'rain':rain,
    'snow':snow,
  };
}
