class ModelQuickWorkout {
  Data? data;

  ModelQuickWorkout({this.data});

  ModelQuickWorkout.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? success;
  List<Quickworkout>? quickworkout;
  String? error;

  Data({this.success, this.quickworkout, this.error});

  Data.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['quickworkout'] != null) {
      quickworkout = [];
      json['quickworkout'].forEach((v) {
        quickworkout!.add(new Quickworkout.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.quickworkout != null) {
      data['quickworkout'] = this.quickworkout!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Quickworkout {
  String? quickworkoutId;
  String? quickworkout;
  String? quickworkoutAr;
  String? image;
  String? desc;

  Quickworkout(
      {this.quickworkoutId,
      this.quickworkout,
      this.quickworkoutAr,
      this.image});

  Quickworkout.fromJson(Map<String, dynamic> json) {
    quickworkoutId = json['quickworkout_id'].toString();
    quickworkout = json['quickworkout'];
    quickworkoutAr = json['quickworkout_ar'];
    image = json['image'];
    desc = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quickworkout_id'] = this.quickworkoutId;
    data['quickworkout'] = this.quickworkout;
    data['image'] = this.image;
    data['description'] = this.desc;
    return data;
  }
}
