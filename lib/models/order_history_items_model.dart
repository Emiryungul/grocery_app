// To parse this JSON data, do
//
//     final orderHistoryItemsModel = orderHistoryItemsModelFromJson(jsonString);

import 'dart:convert';

OrderHistoryItemsModel orderHistoryItemsModelFromJson(String str) => OrderHistoryItemsModel.fromJson(json.decode(str));

String orderHistoryItemsModelToJson(OrderHistoryItemsModel data) => json.encode(data.toJson());

class OrderHistoryItemsModel {
  String? message;
  List<Order>? orders;

  OrderHistoryItemsModel({
    this.message,
    this.orders,
  });

  factory OrderHistoryItemsModel.fromJson(Map<String, dynamic> json) => OrderHistoryItemsModel(
    message: json["message"],
    orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  int? id;
  int? userId;
  int? addressId;
  String? totalPrice;
  String? status;
  String? createdAt;
  String? updatedAt;
  List<Item>? items;

  Order({
    this.id,
    this.userId,
    this.addressId,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    userId: json["user_id"],
    addressId: json["address_id"],
    totalPrice: json["total_price"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "address_id": addressId,
    "total_price": totalPrice,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Item {
  int? id;
  int? orderId;
  int? productId;
  int? quantity;
  String? price;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Item({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
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
  String? updatedAt;
  String? feature;
  String? expiration;
  String? energy;
  int? stock;
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
    this.stock,
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
    stock: json["stock"],
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
    "stock": stock,
    "image_url": imageUrl,
  };
}
