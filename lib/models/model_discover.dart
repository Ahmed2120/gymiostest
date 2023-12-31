import 'dart:convert';

ModelDiscover modelDiscoverFromJson(String str) =>
    ModelDiscover.fromJson(json.decode(str));

String modelDiscoverToJson(ModelDiscover data) => json.encode(data.toJson());

class ModelDiscover {
  ModelDiscover({
    required this.data,
  });

  final Data data;

  factory ModelDiscover.fromJson(Map<String, dynamic> json) => ModelDiscover(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.success,
    required this.discover,
    required this.error,
  });

  final int success;
  final List<Discover> discover;
  final String error;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        success: json["success"],
        discover: List<Discover>.from(
            json["discover"].map((x) => Discover.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "discover": List<dynamic>.from(discover.map((x) => x.toJson())),
        "error": error,
      };
}

class Discover {
  Discover({
    required this.discoverId,
    required this.discover,
    required this.discoverAr,
    required this.image,
    required this.description,
  });

  final String discoverId;
  final String discover;
  final String discoverAr;
  final String image;
  final String description;

  factory Discover.fromJson(Map<String, dynamic> json) => Discover(
        discoverId: json["discover_id"].toString(),
        discover: json["discover"],
        discoverAr: json["discover_ar"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "discover_id": discoverId,
        "discover": discover,
        "image": image,
        "description": description,
      };
}
