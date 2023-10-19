import 'dart:convert';

class Survey {
  String street;
  double rating;
  String? content;

  Survey({
    required this.street,
    required this.rating,
    this.content,
  });

  factory Survey.fromJson(String str) => Survey.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Survey.fromMap(Map<String, dynamic> json) => Survey(
        street: json['street'],
        rating: json['rating'],
        content: json['content'],
      );

  Map<String, dynamic> toMap() => {
        'street': street,
        'rating': rating,
        'content': content,
      };
}
