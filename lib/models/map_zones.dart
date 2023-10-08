import 'dart:convert';

class MapZone {
  List<Zone> zones;

  MapZone({
    required this.zones,
  });

  factory MapZone.fromJson(String str) => MapZone.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MapZone.fromMap(Map<String, dynamic> json) => MapZone(
        zones: List<Zone>.from(json['zones'].map((x) => Zone.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'zones': List<dynamic>.from(zones.map((x) => x.toMap())),
      };
}

class Zone {
  String color;
  String geolocalizacion;
  String modalidad;
  String lugar;
  int sumaX;
  int index;
  String latitud;
  String longitud;

  Zone({
    required this.color,
    required this.modalidad,
    required this.geolocalizacion,
    required this.lugar,
    required this.sumaX,
    required this.index,
    required this.latitud,
    required this.longitud,
  });

  factory Zone.fromJson(String str) => Zone.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Zone.fromMap(Map<String, dynamic> json) => Zone(
        color: json['COLOR'],
        modalidad: json['MODALIDAD'],
        geolocalizacion: json['GEOLOCALIZACION'],
        lugar: json['LUGAR'],
        sumaX: json['SUMA_X'],
        index: json['index'],
        latitud: json['latitud'],
        longitud: json['longitud'],
      );

  Map<String, dynamic> toMap() => {
        'COLOR': color,
        'GEOLOCALIZACION': geolocalizacion,
        'MODALIDAD': modalidad,
        'LUGAR': lugar,
        'SUMA_X': sumaX,
        'index': index,
        'latitud': latitud,
        'longitud': longitud,
      };
}
