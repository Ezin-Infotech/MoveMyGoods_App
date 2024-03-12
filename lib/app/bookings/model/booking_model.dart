import 'dart:convert';

BookingModel bookingModelFromJson(String str) =>
    BookingModel.fromJson(json.decode(str));

class BookingModel {
  String? status;
  BookingData? data;

  BookingModel({
    this.status,
    this.data,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        status: json["status"],
        data: BookingData.fromJson(json["data"]),
      );
}

class BookingData {
  int? totalSize;
  List<ListElement>? list;

  BookingData({
    this.totalSize,
    this.list,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        totalSize: json["totalSize"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );
}

class ListElement {
  int? id;
  int? pickUpDateTime;
  dynamic totalAmount;
  int? paymentMode;
  String? status;
  VehicleImage? vehicleImage;
  GoodsTypeName? goodsTypeName;
  GoodsWeightName? goodsWeightName;
  String? source;
  String? destination;
  String? paymentModeName;

  ListElement({
    this.id,
    this.pickUpDateTime,
    this.totalAmount,
    this.paymentMode,
    this.status,
    this.vehicleImage,
    this.goodsTypeName,
    this.goodsWeightName,
    this.source,
    this.destination,
    this.paymentModeName,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        pickUpDateTime: json["pickUpDateTime"],
        totalAmount: json["totalAmount"],
        paymentMode: json["paymentMode"],
        status: json["status"],
        vehicleImage: VehicleImage.fromJson(json["vehicleImage"]),
        goodsTypeName: GoodsTypeName.fromJson(json["goodsTypeName"]),
        goodsWeightName: GoodsWeightName.fromJson(json["goodsWeightName"]),
        source: json["source"],
        destination: json["destination"],
        paymentModeName: json["paymentModeName"],
      );
}

class GoodsTypeName {
  String? name;
  int? id;

  GoodsTypeName({
    this.name,
    this.id,
  });

  factory GoodsTypeName.fromJson(Map<String, dynamic> json) => GoodsTypeName(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class GoodsWeightName {
  String? weight;
  int? goodsId;

  GoodsWeightName({
    this.weight,
    this.goodsId,
  });

  factory GoodsWeightName.fromJson(Map<String, dynamic> json) =>
      GoodsWeightName(
        weight: json["weight"],
        goodsId: json["goodsId"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "goodsId": goodsId,
      };
}

class VehicleImage {
  String? path;

  VehicleImage({
    this.path,
  });

  factory VehicleImage.fromJson(Map<String, dynamic> json) => VehicleImage(
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "path": path,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
