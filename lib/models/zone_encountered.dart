import 'dart:convert';

class ZoneEncountered {
  CurrentLocation currentLocation;
  String dangerCode;

  ZoneEncountered({
    required this.currentLocation,
    required this.dangerCode,
  });

  factory ZoneEncountered.fromJson(String str) =>
      ZoneEncountered.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZoneEncountered.fromMap(Map<String, dynamic> json) => ZoneEncountered(
        currentLocation: CurrentLocation.fromMap(json['current_location']),
        dangerCode: json['danger_code'],
      );

  Map<String, dynamic> toMap() => {
        'current_location': currentLocation.toMap(),
        'danger_code': dangerCode,
      };
}

class CurrentLocation {
  List<AddressComponent> addressComponents;
  String formattedAddress;
  String placeId;
  List<String> types;

  CurrentLocation({
    required this.addressComponents,
    required this.formattedAddress,
    required this.placeId,
    required this.types,
  });

  factory CurrentLocation.fromJson(String str) =>
      CurrentLocation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CurrentLocation.fromMap(Map<String, dynamic> json) => CurrentLocation(
        addressComponents: List<AddressComponent>.from(
            json['address_components'].map((x) => AddressComponent.fromMap(x))),
        formattedAddress: json['formatted_address'],
        placeId: json['place_id'],
        types: List<String>.from(json['types'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'address_components':
            List<dynamic>.from(addressComponents.map((x) => x.toMap())),
        'formatted_address': formattedAddress,
        'place_id': placeId,
        'types': List<dynamic>.from(types.map((x) => x)),
      };
}

class AddressComponent {
  String longName;
  String shortName;
  List<String> types;

  AddressComponent({
    required this.longName,
    required this.shortName,
    required this.types,
  });

  factory AddressComponent.fromJson(String str) =>
      AddressComponent.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddressComponent.fromMap(Map<String, dynamic> json) =>
      AddressComponent(
        longName: json['long_name'],
        shortName: json['short_name'],
        types: List<String>.from(json['types'].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        'long_name': longName,
        'short_name': shortName,
        'types': List<dynamic>.from(types.map((x) => x)),
      };
}
