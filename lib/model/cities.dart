import 'dart:convert';

Cities citiesFromJson(String str) {
  final jsonData = json.decode(str);
  return Cities.fromMap(jsonData);
}

class Cities{
  final int c_id;
  final String country;
  final String name;
  final double lat;
  final double lon;
  final String defaults;
  final String sets;

  Cities({required this.c_id, required this.country, required this.name, required this.lat, required this.lon, required this.defaults, required this.sets});

  Map<String, dynamic> toMap() => {
    "c_id": c_id,
    "country": country,
    "name": name,
    "lat": lat,
    "lon": lon,
    "defaults": defaults,
    "sets": sets,
  };

  factory Cities.fromMap(Map<String, dynamic> json) => Cities(
    c_id: json['c_id'],
    country: json['country'],
    name: json['name'],
    lat: json['lat'],
    lon: json['lon'],
    defaults: json['defaults'],
    sets: json['sets'],
  );
}
