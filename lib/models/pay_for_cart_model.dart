// To parse this JSON data, do
//
//     final payForCartModel = payForCartModelFromJson(jsonString);

import 'dart:convert';

PayForCartModel payForCartModelFromJson(String str) => PayForCartModel.fromJson(json.decode(str));

String payForCartModelToJson(PayForCartModel data) => json.encode(data.toJson());

class PayForCartModel {
  String? message;
  Errors? errors;

  PayForCartModel({
    this.message,
    this.errors,
  });

  factory PayForCartModel.fromJson(Map<String, dynamic> json) => PayForCartModel(
    message: json["message"],
    errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "errors": errors?.toJson(),
  };
}

class Errors {
  List<String>? addressId;

  Errors({
    this.addressId,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
    addressId: json["address_id"] == null ? [] : List<String>.from(json["address_id"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "address_id": addressId == null ? [] : List<dynamic>.from(addressId!.map((x) => x)),
  };
}
