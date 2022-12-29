class Weather{
  String? main;
  String? description;
  String? icon;

  Weather({this.main, this.description, this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
    main: json['main'] as String?,
    description: json['description'] as String?,
    icon: json['icon'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'main': main,
    'description': description,
    'icon': icon,
  };
}