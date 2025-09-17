// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

List<ContactModel> contactModelFromJson(String str) => List<ContactModel>.from(json.decode(str).map((x) => ContactModel.fromJson(x)));

String contactModelToJson(List<ContactModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ContactModel {
  final String? fullName;
  final String? image;
  final String? phoneNumber;
  final String? id;

  ContactModel({
    this.fullName,
    this.image,
    this.phoneNumber,
    this.id,
  });

  ContactModel copyWith({
    String? fullName,
    String? image,
    String? phoneNumber,
    String? id,
  }) =>
      ContactModel(
        fullName: fullName ?? this.fullName,
        image: image ?? this.image,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        id: id ?? this.id,
      );

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
    fullName: json["fullName"],
    image: json["image"],
    phoneNumber: json["phoneNumber"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "image": image,
    "phoneNumber": phoneNumber,
    "id": id,
  };
}
