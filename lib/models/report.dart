import 'dart:convert';

class Report {
  String address;
  String date;
  String hour;
  String content;
  int? latitude;
  int? longitude;

  Report({
    required this.address,
    required this.date,
    required this.hour,
    required this.content,
    this.latitude,
    this.longitude,
  });

  factory Report.fromJson(String str) => Report.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Report.fromMap(Map<String, dynamic> json) => Report(
        address: json['address'],
        date: json['date'],
        hour: json['hour'],
        content: json['content'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toMap() => {
        'address': address,
        'date': date,
        'hour': hour,
        'content': content,
        'latitude': latitude,
        'longitude': longitude,
      };
}
