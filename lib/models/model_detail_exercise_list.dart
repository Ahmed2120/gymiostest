import 'dart:convert';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

ModelDetailExerciseList modelDetailExerciseListFromJson(String str) =>
    ModelDetailExerciseList.fromJson(json.decode(str));

String modelDetailExerciseListToJson(ModelDetailExerciseList data) =>
    json.encode(data.toJson());

class ModelDetailExerciseList {
  ModelDetailExerciseList({
    required this.data,
  });

  Data data;

  factory ModelDetailExerciseList.fromJson(Map<String, dynamic> json) =>
      ModelDetailExerciseList(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.success,
    required this.exercise,
    required this.error,
  });

  final int success;
  final List<Exercise> exercise;
  final String error;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        exercise: List<Exercise>.from(
            json["exercise"].map((x) => Exercise.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "exercise": List<dynamic>.from(exercise.map((x) => x.toJson())),
        "error": error,
      };
}

class Exercise {
  Exercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseNameAr,
    required this.image,
    required this.thumb,
    required this.description,
    required this.exerciseTime,
  });

  String exerciseId;
  String exerciseName;
  String image;
  String thumb;
  String description;
  String exerciseTime;
  String exerciseNameAr;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        exerciseId: json["exercise_id"].toString(),
        exerciseName: json["exercise_name"],
        exerciseNameAr: json["exercise_name_ar"],
        image: json["image"].contains('youtu')
            ? YoutubePlayer.convertUrlToId(json["image"]) ?? ''
            : json["image"],
        thumb: json["thumb"],
        description: json["description"],
        exerciseTime: json["exercise_time"],
      );

  Map<String, dynamic> toJson() => {
        "exercise_id": exerciseId,
        "exercise_name": exerciseName,
        "image": image,
        "description": description,
        "exercise_time": exerciseTime,
      };
}
