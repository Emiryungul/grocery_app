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
  int? userId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Favorite({
    this.id,
    this.userId,
    this.productId,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
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
  String? imagePath;
  int? categoryId;
  dynamic createdAt;
  dynamic updatedAt;
  String? feature;
  String? expiration;
  String? energy;
  String? imageUrl;

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imagePath,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.feature,
    this.expiration,
    this.energy,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imagePath: json["image_path"],
    categoryId: json["category_id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    feature: json["feature"],
    expiration: json["expiration"],
    energy: json["energy"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "image_path": imagePath,
    "category_id": categoryId,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "feature": feature,
    "expiration": expiration,
    "energy": energy,
    "image_url": imageUrl,
  };
}
