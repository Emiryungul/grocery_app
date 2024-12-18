// To parse this JSON data, do
//
//     final addUserAddressModel = addUserAddressModelFromJson(jsonString);

import 'dart:convert';

AddUserAddressModel addUserAddressModelFromJson(String str) => AddUserAddressModel.fromJson(json.decode(str));

String addUserAddressModelToJson(AddUserAddressModel data) => json.encode(data.toJson());

class AddUserAddressModel {
  String? message;
  Address? address;

  AddUserAddressModel({
    this.message,
    this.address,
  });

  factory AddUserAddressModel.fromJson(Map<String, dynamic> json) => AddUserAddressModel(
    message: json["message"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "address": address?.toJson(),
  };
}

class Address {
  int? userId;
  String? marker;
  String? address;
  double? lat;
  double? lon;
  String? name;
  String? postCode;
  String? updatedAt;
  String? createdAt;
  int? id;

  Address({
    this.userId,
    this.marker,
    this.address,
    this.lat,
    this.lon,
    this.name,
    this.postCode,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    userId: json["user_id"],
    marker: json["marker"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    name: json["name"],
    postCode: json["post_code"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "marker": marker,
    "address": address,
    "lat": lat,
    "lon": lon,
    "name": name,
    "post_code": postCode,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "id": id,
  };
}
