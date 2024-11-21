// To parse this JSON data, do
//
//     final favoritesModel = favoritesModelFromJson(jsonString);

import 'dart:convert';

FavoritesModel favoritesModelFromJson(String str) => FavoritesModel.fromJson(json.decode(str));

String favoritesModelToJson(FavoritesModel data) => json.encode(data.toJson());

class FavoritesModel {
  String? message;
  List<Favorite>? favorites;

  FavoritesModel({
    this.message,
    this.favorites,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) => FavoritesModel(
    message: json["message"],
    favorites: json["favorites"] == null ? [] : List<Favorite>.from(json["favorites"]!.map((x) => Favorite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "favorites": favorites == null ? [] : List<dynamic>.from(favorites!.map((x) => x.toJson())),
  };
}

class Favorite {
  int? id;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Favorite({
    this.id,
    this.productId,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    productId: json["product_id"],
    userId: json["user_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "user_id": userId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? name;
  String? description;
  String? price;
  String? imageUrl;
  String? feature;
  String? expiration;
  String? energy;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imageUrl,
    this.feature,
    this.expiration,
    this.energy,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["image_url"],
    feature: json["feature"],
    expiration: json["expiration"],
    energy: json["energy"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "image_url": imageUrl,
    "feature": feature,
    "expiration": expiration,
    "energy": energy,
  };
}
