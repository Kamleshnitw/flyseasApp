// To parse this JSON data, do
//
//     final cityListResponse = cityListResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CityListResponse cityListResponseFromJson(String str) => CityListResponse.fromJson(json.decode(str));

String cityListResponseToJson(CityListResponse data) => json.encode(data.toJson());

class CityListResponse {
  CityListResponse({
    required this.success,
    required this.city,
  });

  bool success;
  List<City> city;

  factory CityListResponse.fromJson(Map<String, dynamic> json) => CityListResponse(
    success: json["success"],
    city: List<City>.from(json["city"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "city": List<dynamic>.from(city.map((x) => x.toJson())),
  };
}

class City {
  City({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
