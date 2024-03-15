// To parse this JSON data, do
//
//     final cityListModel = cityListModelFromJson(jsonString);

import 'dart:convert';

CityListModel cityListModelFromJson(String str) =>
    CityListModel.fromJson(json.decode(str));

class CityListModel {
  String? status;
  CityData? data;

  CityListModel({
    this.status,
    this.data,
  });

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
        status: json["status"],
        data: CityData.fromJson(json["data"]),
      );
}

class CityData {
  num? totalSize;
  List<CityListElement>? list;

  CityData({
    this.totalSize,
    this.list,
  });

  factory CityData.fromJson(Map<String, dynamic> json) => CityData(
        totalSize: json["totalSize"],
        list: List<CityListElement>.from(
            json["list"].map((x) => CityListElement.fromJson(x))),
      );
}

class CityListElement {
  String? name;
  num? id;
  num? stateId;

  CityListElement({
    this.name,
    this.id,
    this.stateId,
  });

  factory CityListElement.fromJson(Map<String, dynamic> json) =>
      CityListElement(
        name: json["name"],
        id: json["id"],
        stateId: json["state_id"],
      );
}
