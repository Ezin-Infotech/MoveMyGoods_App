// To parse this JSON data, do
//
//     final goodsWeightModel = goodsWeightModelFromJson(jsonString);

import 'dart:convert';

GoodsWeightModel goodsWeightModelFromJson(String str) =>
    GoodsWeightModel.fromJson(json.decode(str));

class GoodsWeightModel {
  String? status;
  GoodsWeightData? data;

  GoodsWeightModel({
    this.status,
    this.data,
  });

  factory GoodsWeightModel.fromJson(Map<String, dynamic> json) =>
      GoodsWeightModel(
        status: json["status"],
        data: GoodsWeightData.fromJson(json["data"]),
      );
}

class GoodsWeightData {
  num? distance;
  List<FareWeightList>? fareWeightList;

  GoodsWeightData({
    this.distance,
    this.fareWeightList,
  });

  factory GoodsWeightData.fromJson(Map<String, dynamic> json) =>
      GoodsWeightData(
        distance: json["distance"],
        fareWeightList: List<FareWeightList>.from(
            json["fareWeightList"].map((x) => FareWeightList.fromJson(x))),
      );
}

class FareWeightList {
  num? weightId;
  String? weight;
  num? totalAmount;

  FareWeightList({
    this.weightId,
    this.weight,
    this.totalAmount,
  });

  factory FareWeightList.fromJson(Map<String, dynamic> json) => FareWeightList(
        weightId: json["weightId"],
        weight: json["weight"],
        totalAmount: json["totalAmount"],
      );
}
