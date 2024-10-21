// To parse this JSON data, do
//
//     final allProductsModel = allProductsModelFromJson(jsonString);

import 'dart:convert';

AllProductsModel allProductsModelFromJson(String str) => AllProductsModel.fromJson(json.decode(str));

String allProductsModelToJson(AllProductsModel data) => json.encode(data.toJson());

class AllProductsModel {
  List<Datum>? data;

  AllProductsModel({
    this.data,
  });

  factory AllProductsModel.fromJson(Map<String, dynamic> json) => AllProductsModel(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  List<Product>? products;
  String? createdAt;
  String? updatedAt;

  Datum({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.products,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageUrl: json["image_url"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image_url": imageUrl,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
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

  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.imagePath,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
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
  };
}
