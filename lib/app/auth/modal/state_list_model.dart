// To parse this JSON data, do
//
//     final cityListModel = cityListModelFromJson(jsonString);

import 'dart:convert';

StateListModel stateListModelFromJson(String str) =>
    StateListModel.fromJson(json.decode(str));

class StateListModel {
  String? status;
  StateData? data;

  StateListModel({
    this.status,
    this.data,
  });

  factory StateListModel.fromJson(Map<String, dynamic> json) => StateListModel(
        status: json["status"],
        data: StateData.fromJson(json["data"]),
      );
}

class StateData {
  num? totalSize;
  List<StateListElement>? list;

  StateData({
    this.totalSize,
    this.list,
  });

  factory StateData.fromJson(Map<String, dynamic> json) => StateData(
        totalSize: json["totalSize"],
        list: List<StateListElement>.from(
            json["list"].map((x) => StateListElement.fromJson(x))),
      );
}

class StateListElement {
  num? id;
  String? name;
  num? countryId;
  String? shortName;

  StateListElement({
    this.id,
    this.name,
    this.countryId,
    this.shortName,
  });

  factory StateListElement.fromJson(Map<String, dynamic> json) =>
      StateListElement(
        id: json["id"],
        name: json["name"],
        countryId: json["country_id"],
        shortName: json["shortName"],
      );
}
