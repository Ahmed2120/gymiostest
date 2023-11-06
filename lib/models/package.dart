// To parse this JSON data, do
//
//     final package = packageFromJson(jsonString);

import 'dart:convert';

List<Package> packageFromJson(String str) =>
    List<Package>.from(json.decode(str).map((x) => Package.fromJson(x)));

class Package {
  Package({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.createdAt,
    //  required this.updatedAt,
  });

  String id;
  String name;
  String duration;
  String price;
  String isActive;
  DateTime createdAt;
  // DateTime updatedAt;

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        name: json["name"],
        duration: json["duration"],
        price: json["price"],
        isActive: json["is_active"],
        createdAt: DateTime.parse(json["created_at"]),
        // updatedAt: DateTime.parse(json["updated_at"]),
      );
}
