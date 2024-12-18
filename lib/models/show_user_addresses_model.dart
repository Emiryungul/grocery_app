// To parse this JSON data, do
//
//     final showUserAddressesModel = showUserAddressesModelFromJson(jsonString);

import 'dart:convert';

ShowUserAddressesModel showUserAddressesModelFromJson(String str) => ShowUserAddressesModel.fromJson(json.decode(str));

String showUserAddressesModelToJson(ShowUserAddressesModel data) => json.encode(data.toJson());

class ShowUserAddressesModel {
  String? message;
  List<Address>? addresses;

  ShowUserAddressesModel({
    this.message,
    this.addresses,
  });

  factory ShowUserAddressesModel.fromJson(Map<String, dynamic> json) => ShowUserAddressesModel(
    message: json["message"],
    addresses: json["addresses"] == null ? [] : List<Address>.from(json["addresses"]!.map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "addresses": addresses == null ? [] : List<dynamic>.from(addresses!.map((x) => x.toJson())),
  };
}

class Address {
  int? id;
  int? userId;
  String? marker;
  String? address;
  String? lat;
  String? lon;
  String? name;
  String? postCode;
  String? createdAt;
  String? updatedAt;

  Address({
    this.id,
    this.userId,
    this.marker,
    this.address,
    this.lat,
    this.lon,
    this.name,
    this.postCode,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    userId: json["user_id"],
    marker: json["marker"],
    address: json["address"],
    lat: json["lat"],
    lon: json["lon"],
    name: json["name"],
    postCode: json["post_code"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "marker": marker,
    "address": address,
    "lat": lat,
    "lon": lon,
    "name": name,
    "post_code": postCode,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
