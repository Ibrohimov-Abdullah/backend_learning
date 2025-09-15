// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  final String? name;
  final int? age;
  final String? id;

  ProductModel({
    this.name,
    this.age,
    this.id,
  });

  ProductModel copyWith({
    String? name,
    int? age,
    String? id,
  }) =>
      ProductModel(
        name: name ?? this.name,
        age: age ?? this.age,
        id: id ?? this.id,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    name: json["name"],
    age: json["age"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "age": age,
    "id": id,
  };
}
