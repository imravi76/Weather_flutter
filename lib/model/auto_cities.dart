import 'dart:convert';

AutoCities citiesFromJson(String str) {
  final jsonData = json.decode(str);
  return AutoCities.fromMap(jsonData);
}

class AutoCities{
  final int c_id;
  final String country;
  final String name;
  final double lat;
  final double lon;

  AutoCities({required this.c_id, required this.country, required this.name, required this.lat, required this.lon});

  Map<String, dynamic> toMap() => {
    "c_id": c_id,
    "country": country,
    "name": name,
    "lat": lat,
    "lon": lon,
  };

  factory AutoCities.fromMap(Map<String, dynamic> json) => AutoCities(
    c_id: json['c_id'],
    country: json['country'],
    name: json['name'],
    lat: json['lat'],
    lon: json['lon'],
  );
}
