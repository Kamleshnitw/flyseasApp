// To parse this JSON data, do
//
//     final errorRegisterResponse = errorRegisterResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ErrorRegisterResponse errorRegisterResponseFromJson(String str) => ErrorRegisterResponse.fromJson(json.decode(str));

String errorRegisterResponseToJson(ErrorRegisterResponse data) => json.encode(data.toJson());

class ErrorRegisterResponse {
  ErrorRegisterResponse({
    required this.message,
    required this.errors,
  });

  String message;
  Errors errors;

  factory ErrorRegisterResponse.fromJson(Map<String, dynamic> json) => ErrorRegisterResponse(
    message: json["message"],
    errors: Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors.toJson(),
  };
}

class Errors {
  Errors(
     this.name,
     this.phoneNumber,
     this.email,
     this.password,
  );

  List<String> name;
  List<String> phoneNumber;
  List<String> email;
  List<String> password;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
     List<String>.from(json["name"]!=null ? json["name"].map((x) => x) : []),
     List<String>.from(json["phone_number"]!=null ? json["phone_number"].map((x) => x) : []),
     List<String>.from(json["email"]!=null ? json["email"].map((x) => x) : []),
     List<String>.from(json["password"]!=null ? json["password"].map((x) => x): []),
  );

  Map<String, dynamic> toJson() => {
    "name": List<dynamic>.from(name.map((x) => x)),
    "phone_number": List<dynamic>.from(phoneNumber.map((x) => x)),
    "email": List<dynamic>.from(email.map((x) => x)),
    "password": List<dynamic>.from(password.map((x) => x)),
  };
}
