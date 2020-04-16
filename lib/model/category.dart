// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  final String id;
  final String name;
  final String description;
  final String status;
  final String image;

  Category({
    this.id,
    this.name,
    this.description,
    this.status,
    this.image,
  });

  Category copyWith({
    String id,
    String name,
    String description,
    String status,
    String image,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        status: status ?? this.status,
        image: image ?? this.image,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    status: json["status"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "status": status,
    "image": image,
  };
}
