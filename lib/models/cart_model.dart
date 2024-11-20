// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  List<Datum>? data;
  Meta? meta;

  CartModel({
    this.data,
    this.meta,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "meta": meta?.toJson(),
  };
}

class Datum {
  int? productId;
  String? name;
  String? imageUrl;
  int? quantity;
  String? price;
  int? totalPrice;

  Datum({
    this.productId,
    this.name,
    this.imageUrl,
    this.quantity,
    this.price,
    this.totalPrice,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    productId: json["product_id"],
    name: json["name"],
    imageUrl: json["image_url"],
    quantity: json["quantity"],
    price: json["price"],
    totalPrice: json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "name": name,
    "image_url": imageUrl,
    "quantity": quantity,
    "price": price,
    "total_price": totalPrice,
  };
}

class Meta {
  int? totalPrice;
  String? message;

  Meta({
    this.totalPrice,
    this.message,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    totalPrice: json["totalPrice"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "totalPrice": totalPrice,
    "message": message,
  };
}
