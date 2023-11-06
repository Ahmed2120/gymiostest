// To parse this JSON data, do
//
//     final modelAllWorkout = modelAllWorkoutFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

ModelAllWorkout modelAllWorkoutFromJson(String str) =>
    ModelAllWorkout.fromJson(json.decode(str));

String modelAllWorkoutToJson(ModelAllWorkout data) =>
    json.encode(data.toJson());

class ModelAllWorkout {
  ModelAllWorkout({
    required this.data,
  });

  final Data data;

  factory ModelAllWorkout.fromJson(Map<String, dynamic> json) =>
      ModelAllWorkout(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.success,
    required this.category,
    required this.error,
  });

  final int success;
  final List<Category> category;
  final String error;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "error": error,
      };
}

class Category {
  Category(
      {required this.categoryId,
      required this.category,
      required this.image,
      required this.hasChildren,
      required this.description,
      required this.categoryAr,
      required this.descriptionAr,
      required this.isPro});

  final String categoryId;
  final String category;
  final String categoryAr;
  final String image;
  final String description;
  final String descriptionAr;
  final bool hasChildren;
  final bool isPro;
  factory Category.fromJson(Map<String, dynamic> json) {
    log("category" + json.toString());

    return Category(
        categoryId: json["category_id"].toString(),
        category: json["category"],
        categoryAr: json["category_ar"],
        descriptionAr: json["description_ar"],
        image: json["image"],
        hasChildren: json["child_count"] != 0,
        description: json["description"],
        isPro: json["is_active"] == 1);
  }

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category": category,
        "image": image,
        "description": description,
      };
}
