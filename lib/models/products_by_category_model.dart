// To parse this JSON data, do
//
//     final productsByCategoryModel = productsByCategoryModelFromJson(jsonString);

import 'dart:convert';

ProductsByCategoryModel productsByCategoryModelFromJson(String str) => ProductsByCategoryModel.fromJson(json.decode(str));

String productsByCategoryModelToJson(ProductsByCategoryModel data) => json.encode(data.toJson());

class ProductsByCategoryModel {
  Data? data;

  ProductsByCategoryModel({
    this.data,
  });

  factory ProductsByCategoryModel.fromJson(Map<String, dynamic> json) => ProductsByCategoryModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  Category? category;
  List<Product>? products;

  Data({
    this.category,
    this.products,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "category": category?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
  };
}

class Category {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image_url": imageUrl,
    "created_at": createdAt,
    "updated_at": updatedAt,
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
