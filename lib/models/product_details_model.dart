// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

ProductDetailModel productDetailModelFromJson(String str) => ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) => json.encode(data.toJson());

class ProductDetailModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? imagePath;
  int? categoryId;
  dynamic createdAt;
  String? updatedAt;
  String? feature;
  String? expiration;
  String? energy;
  int? stock;
  String? imageUrl;
  Category? category;

  ProductDetailModel({
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
    this.stock,
    this.imageUrl,
    this.category,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => ProductDetailModel(
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
    stock: json["stock"],
    imageUrl: json["image_url"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
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
    "stock": stock,
    "image_url": imageUrl,
    "category": category?.toJson(),
  };
}

class Category {
  int? id;
  String? name;
  String? description;
  String? imagePath;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.imagePath,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imagePath: json["image_path"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image_path": imagePath,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
