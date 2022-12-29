

class WeatherDataAlert{
  List<Alert> alert;
  WeatherDataAlert({required this.alert});

  factory WeatherDataAlert.fromJson(Map<String, dynamic> json) =>
      WeatherDataAlert(alert: json['alerts'] != null ?
      List<Alert>.from(json['alerts'].map((e) => Alert.fromJson(e))) : <Alert>[]);
}

class Alert {
  String? senderName;
  String? event;
  int? start;
  int? end;
  String? description;

  Alert({
    this.senderName,
    this.event,
    this.start,
    this.end,
    this.description,
  });

  factory Alert.fromJson(Map<String, dynamic> json) => Alert(
        senderName: json['sender_name'] as String?,
        event: json['event'] as String?,
        start: json['start'] as int?,
        end: json['end'] as int?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'sender_name': senderName,
        'event': event,
        'start': start,
        'end': end,
        'description': description,
      };
}
