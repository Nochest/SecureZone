import 'dart:convert';

class Account {
  String names;
  String email;
  String phome;
  String pasword;
  String dni;
  String? imageEncoded;
  bool? phoneVerification;

  Account({
    required this.names,
    required this.email,
    required this.phome,
    required this.pasword,
    required this.dni,
    this.imageEncoded,
    this.phoneVerification,
  });

  factory Account.fromRawJson(String str) => Account.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        names: json['names'],
        email: json['email'],
        phome: json['phone'],
        pasword: json['password'],
        dni: json['dni'],
        imageEncoded: json['imageEncoded'],
        phoneVerification: json['phoneVerification'],
      );

  Map<String, dynamic> toJson() => {
        'names': names,
        'email': email,
        'phone': phome,
        'password': pasword,
        'dni': dni,
        'imageEncoded': imageEncoded,
        'phoneVerification': phoneVerification,
      };
}
