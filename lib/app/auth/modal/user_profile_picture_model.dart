// To parse this JSON data, do
//
//     final userProfilePicModel = userProfilePicModelFromJson(jsonString);

import 'dart:convert';

UserProfilePicModel userProfilePicModelFromJson(String str) =>
    UserProfilePicModel.fromJson(json.decode(str));

class UserProfilePicModel {
  String? status;
  List<Datum>? data;

  UserProfilePicModel({
    this.status,
    this.data,
  });

  factory UserProfilePicModel.fromJson(Map<String, dynamic> json) =>
      UserProfilePicModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  String? uuid;
  String? name;
  String? type;
  String? path;
  String? category;
  bool? isActive;

  Datum({
    this.uuid,
    this.name,
    this.type,
    this.path,
    this.category,
    this.isActive,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uuid: json["uuid"],
        name: json["name"],
        type: json["type"],
        path: json["path"],
        category: json["category"],
        isActive: json["isActive"],
      );
}
