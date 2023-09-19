// To parse this JSON data, do
//
//     final getProductListModel = getProductListModelFromJson(jsonString);

import 'dart:convert';

List<GetProductListModel> getProductListModelFromJson(String str) =>
    List<GetProductListModel>.from(
        json.decode(str).map((x) => GetProductListModel.fromJson(x)));

String getProductListModelToJson(List<GetProductListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetProductListModel {
  int? userId;
  int? id;
  String? title;
  bool? completed;
  bool isFavorite;
  int isCartQuantity;
  int price;

  GetProductListModel({
    this.userId,
    this.id,
    this.title,
    this.completed,
    this.isFavorite = false,
    this.isCartQuantity = 0,
    this.price = 10
  });

  factory GetProductListModel.fromJson(Map<String, dynamic> json) =>
      GetProductListModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
        isFavorite: json["isFavorite"] ?? false,
        isCartQuantity: json["isCartQuantity"] ?? 0,
        price: json["price"] ?? 10,
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
        "isFavorite": isFavorite,
        "isCartQuantity": isCartQuantity,
        "price": price,
      };
}
