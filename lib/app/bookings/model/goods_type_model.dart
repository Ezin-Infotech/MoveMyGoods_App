// To parse this JSON data, do
//
//     final goodsTypeModel = goodsTypeModelFromJson(jsonString);

import 'dart:convert';

GoodsTypeModel goodsTypeModelFromJson(String str) =>
    GoodsTypeModel.fromJson(json.decode(str));

class GoodsTypeModel {
  String? status;
  GoodsTypData? data;

  GoodsTypeModel({
    this.status,
    this.data,
  });

  factory GoodsTypeModel.fromJson(Map<String, dynamic> json) => GoodsTypeModel(
        status: json["status"],
        data: GoodsTypData.fromJson(json["data"]),
      );
}

class GoodsTypData {
  int? totalSize;
  List<GoodsTypeElement>? list;

  GoodsTypData({
    this.totalSize,
    this.list,
  });

  factory GoodsTypData.fromJson(Map<String, dynamic> json) => GoodsTypData(
        totalSize: json["totalSize"],
        list: List<GoodsTypeElement>.from(
            json["list"].map((x) => GoodsTypeElement.fromJson(x))),
      );
}

class GoodsTypeElement {
  int? id;
  String? name;
  bool? status;
  DateTime? creationDate;
  DateTime? modificationDate;
  bool? profitable;

  GoodsTypeElement({
    this.id,
    this.name,
    this.status,
    this.creationDate,
    this.modificationDate,
    this.profitable,
  });

  factory GoodsTypeElement.fromJson(Map<String, dynamic> json) =>
      GoodsTypeElement(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        creationDate: DateTime.parse(json["creationDate"]),
        modificationDate: DateTime.parse(json["modificationDate"]),
        profitable: json["profitable"],
      );
}
