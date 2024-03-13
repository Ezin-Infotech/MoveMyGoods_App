// To parse this JSON data, do
//
//     final bookingDetailsModel = bookingDetailsModelFromJson(jsonString);

import 'dart:convert';

BookingDetailsModel bookingDetailsModelFromJson(String str) =>
    BookingDetailsModel.fromJson(json.decode(str));

class BookingDetailsModel {
  String? status;
  BookingDetailsData? data;

  BookingDetailsModel({
    this.status,
    this.data,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailsModel(
        status: json["status"],
        data: BookingDetailsData.fromJson(json["data"]),
      );
}

class BookingDetailsData {
  int? id;
  String? bookingType;
  String? referenceId;
  String? vendorType;
  String? profileId;
  double? sourcelatitude;
  double? sourcelongitude;
  String? sStreet;
  String? sCity;
  String? sState;
  String? sCountry;
  String? sLandMark;
  int? sPincode;
  double? destinationlatitude;
  double? destinationlongitude;
  String? dStreet;
  String? dCity;
  String? dState;
  String? dCountry;
  int? dPincode;
  double? distance;
  int? goodsWeightId;
  int? goodsTypeId;
  String? vehicleCategoryId;
  int? perKm;
  int? baseFare;
  String? vehicleId;
  int? numberofLabours;
  int? goodsvalue;
  int? pickUpDateTime;
  String? consignorName;
  String? consignorNumber;
  String? consigneeName;
  String? consigneeNumber;
  String? consigneeGst;
  String? consigneePan;
  int? bookedGoodsTypes;
  int? bookingAmount;
  int? labourCharges;
  int? labourChargesPerHead;
  int? totalAmount;
  int? advCompType;
  int? paymentMode;
  int? paymentMethod;
  int? creationDate;
  int? modifiedDate;
  String? status;
  bool? isActive;
  int? cancelledByCustomer;
  String? bookedBy;
  List<dynamic>? bookedItems;
  VehicleImage? vehicleImage;
  GoodsTypeName? goodsTypeName;
  GoodsWeightName? goodsWeightName;
  String? source;
  String? destination;
  Customer? customer;
  int? fodBy;
  List<dynamic>? packageDetails;
  String? supplyType;
  int? customerFare;
  int? actualFare;
  int? offerAmount;
  double? cgst;
  double? sgst;

  BookingDetailsData({
    this.id,
    this.bookingType,
    this.referenceId,
    this.vendorType,
    this.profileId,
    this.sourcelatitude,
    this.sourcelongitude,
    this.sStreet,
    this.sCity,
    this.sState,
    this.sCountry,
    this.sLandMark,
    this.sPincode,
    this.destinationlatitude,
    this.destinationlongitude,
    this.dStreet,
    this.dCity,
    this.dState,
    this.dCountry,
    this.dPincode,
    this.distance,
    this.goodsWeightId,
    this.goodsTypeId,
    this.vehicleCategoryId,
    this.perKm,
    this.baseFare,
    this.vehicleId,
    this.numberofLabours,
    this.goodsvalue,
    this.pickUpDateTime,
    this.consignorName,
    this.consignorNumber,
    this.consigneeName,
    this.consigneeNumber,
    this.consigneeGst,
    this.consigneePan,
    this.bookedGoodsTypes,
    this.bookingAmount,
    this.labourCharges,
    this.labourChargesPerHead,
    this.totalAmount,
    this.advCompType,
    this.paymentMode,
    this.paymentMethod,
    this.creationDate,
    this.modifiedDate,
    this.status,
    this.isActive,
    this.cancelledByCustomer,
    this.bookedBy,
    this.bookedItems,
    this.vehicleImage,
    this.goodsTypeName,
    this.goodsWeightName,
    this.source,
    this.destination,
    this.customer,
    this.fodBy,
    this.packageDetails,
    this.supplyType,
    this.customerFare,
    this.actualFare,
    this.offerAmount,
    this.cgst,
    this.sgst,
  });

  factory BookingDetailsData.fromJson(Map<String, dynamic> json) =>
      BookingDetailsData(
        id: json["id"],
        bookingType: json["bookingType"],
        referenceId: json["referenceId"],
        vendorType: json["vendorType"],
        profileId: json["profileId"],
        sourcelatitude: json["sourcelatitude"].toDouble(),
        sourcelongitude: json["sourcelongitude"].toDouble(),
        sStreet: json["sStreet"],
        sCity: json["sCity"],
        sState: json["sState"],
        sCountry: json["sCountry"],
        sLandMark: json["sLandMark"],
        sPincode: json["sPincode"],
        destinationlatitude: json["destinationlatitude"].toDouble(),
        destinationlongitude: json["destinationlongitude"].toDouble(),
        dStreet: json["dStreet"],
        dCity: json["dCity"],
        dState: json["dState"],
        dCountry: json["dCountry"],
        dPincode: json["dPincode"],
        distance: json["distance"].toDouble(),
        goodsWeightId: json["goodsWeightId"],
        goodsTypeId: json["goodsTypeId"],
        vehicleCategoryId: json["vehicleCategoryId"],
        perKm: json["perKm"],
        baseFare: json["baseFare"],
        vehicleId: json["vehicleId"],
        numberofLabours: json["numberofLabours"],
        goodsvalue: json["goodsvalue"],
        pickUpDateTime: json["pickUpDateTime"],
        consignorName: json["consignorName"],
        consignorNumber: json["consignorNumber"],
        consigneeName: json["consigneeName"],
        consigneeNumber: json["consigneeNumber"],
        consigneeGst: json["consigneeGST"],
        consigneePan: json["consigneePAN"],
        bookedGoodsTypes: json["bookedGoodsTypes"],
        bookingAmount: json["bookingAmount"],
        labourCharges: json["labourCharges"],
        labourChargesPerHead: json["labourChargesPerHead"],
        totalAmount: json["totalAmount"],
        advCompType: json["advCompType"],
        paymentMode: json["paymentMode"],
        paymentMethod: json["paymentMethod"],
        creationDate: json["creationDate"],
        modifiedDate: json["modifiedDate"],
        status: json["status"],
        isActive: json["isActive"],
        cancelledByCustomer: json["cancelledByCustomer"],
        bookedBy: json["bookedBy"],
        bookedItems: List<dynamic>.from(json["bookedItems"].map((x) => x)),
        vehicleImage: VehicleImage.fromJson(json["vehicleImage"]),
        goodsTypeName: GoodsTypeName.fromJson(json["goodsTypeName"]),
        goodsWeightName: GoodsWeightName.fromJson(json["goodsWeightName"]),
        source: json["source"],
        destination: json["destination"],
        customer: Customer.fromJson(json["customer"]),
        fodBy: json["fodBy"],
        packageDetails:
            List<dynamic>.from(json["packageDetails"].map((x) => x)),
        supplyType: json["supplyType"],
        customerFare: json["customerFare"],
        actualFare: json["actualFare"],
        offerAmount: json["offerAmount"],
        cgst: json["cgst"].toDouble(),
        sgst: json["sgst"].toDouble(),
      );
}

class Customer {
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? emailId;

  Customer({
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.emailId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        firstName: json["firstName"],
        lastName: json["lastName"],
        mobileNumber: json["mobileNumber"],
        emailId: json["emailId"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "mobileNumber": mobileNumber,
        "emailId": emailId,
      };
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
