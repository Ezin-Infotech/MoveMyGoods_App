// To parse this JSON data, do
//
//     final goodsVehicleDetailsModel = goodsVehicleDetailsModelFromJson(jsonString);

import 'dart:convert';

GoodsVehicleDetailsModel goodsVehicleDetailsModelFromJson(String str) =>
    GoodsVehicleDetailsModel.fromJson(json.decode(str));

class GoodsVehicleDetailsModel {
  String? status;
  List<GoodsVehicleDetailsDatum>? data;

  GoodsVehicleDetailsModel({
    this.status,
    this.data,
  });

  factory GoodsVehicleDetailsModel.fromJson(Map<String, dynamic> json) =>
      GoodsVehicleDetailsModel(
        status: json["status"],
        data: List<GoodsVehicleDetailsDatum>.from(
            json["data"].map((x) => GoodsVehicleDetailsDatum.fromJson(x))),
      );
}

class GoodsVehicleDetailsDatum {
  String? vehicleId;
  num? vehicleCategoryId;
  String? category;
  String? goodsTypeId;
  String? kerbWeightId;
  String? path;
  String? name;
  String? imageId;
  String? vendorType;
  String? vendorId;

  GoodsVehicleDetailsDatum({
    this.vehicleId,
    this.vehicleCategoryId,
    this.category,
    this.goodsTypeId,
    this.kerbWeightId,
    this.path,
    this.name,
    this.imageId,
    this.vendorType,
    this.vendorId,
  });

  factory GoodsVehicleDetailsDatum.fromJson(Map<String, dynamic> json) =>
      GoodsVehicleDetailsDatum(
        vehicleId: json["vehicleId"],
        vehicleCategoryId: json["vehicleCategoryId"],
        category: json["category"],
        goodsTypeId: json["goodsTypeId"],
        kerbWeightId: json["kerbWeightId"],
        path: json["path"],
        name: json["name"],
        imageId: json["imageId"],
        vendorType: json["vendorType"],
        vendorId: json["vendorId"],
      );
}
