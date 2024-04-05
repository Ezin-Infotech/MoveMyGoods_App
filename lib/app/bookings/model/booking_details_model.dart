// // To parse this JSON data, do
// //
// //     final bookingDetailsModel = bookingDetailsModelFromJson(jsonString);

// import 'dart:convert';

// BookingDetailsModel bookingDetailsModelFromJson(String str) =>
//     BookingDetailsModel.fromJson(json.decode(str));

// class BookingDetailsModel {
//   String? status;
//   BookingDetailsData? data;

//   BookingDetailsModel({
//     this.status,
//     this.data,
//   });

//   factory BookingDetailsModel.fromJson(Map<String, dynamic> json) =>
//       BookingDetailsModel(
//         status: json["status"],
//         data: BookingDetailsData.fromJson(json["data"]),
//       );
// }

// class BookingDetailsData {
//   dynamic id;
//   String? bookingType;
//   String? referenceId;
//   String? vendorType;
//   String? profileId;
//   dynamic sourcelatitude;
//   dynamic sourcelongitude;
//   String? sStreet;
//   String? sCity;
//   String? sState;
//   String? sCountry;
//   String? sLandMark;
//   dynamic sPincode;
//   dynamic destinationlatitude;
//   dynamic destinationlongitude;
//   String? dStreet;
//   String? dCity;
//   String? dState;
//   String? dCountry;
//   dynamic dPincode;
//   dynamic distance;
//   dynamic goodsWeightId;
//   dynamic goodsTypeId;
//   String? vehicleCategoryId;
//   dynamic perKm;
//   dynamic baseFare;
//   String? vehicleId;
//   dynamic numberofLabours;
//   dynamic goodsvalue;
//   dynamic pickUpDateTime;
//   String? consignorName;
//   String? consignorNumber;
//   String? consigneeName;
//   String? consigneeNumber;
//   String? consigneeGst;
//   String? consigneePan;
//   dynamic bookedGoodsTypes;
//   dynamic bookingAmount;
//   dynamic labourCharges;
//   dynamic labourChargesPerHead;
//   dynamic totalAmount;
//   dynamic advCompType;
//   dynamic paymentMode;
//   dynamic paymentMethod;
//   dynamic creationDate;
//   dynamic modifiedDate;
//   String? status;
//   bool? isActive;
//   dynamic cancelledByCustomer;
//   String? bookedBy;
//   List<dynamic>? bookedItems;
//   VehicleImage? vehicleImage;
//   GoodsTypeName? goodsTypeName;
//   GoodsWeightName? goodsWeightName;
//   String? source;
//   String? destination;
//   Customer? customer;
//   dynamic fodBy;
//   List<dynamic>? packageDetails;
//   String? supplyType;
//   dynamic customerFare;
//   dynamic actualFare;
//   dynamic offerAmount;
//   dynamic cgst;
//   dynamic sgst;

//   BookingDetailsData({
//     this.id,
//     this.bookingType,
//     this.referenceId,
//     this.vendorType,
//     this.profileId,
//     this.sourcelatitude,
//     this.sourcelongitude,
//     this.sStreet,
//     this.sCity,
//     this.sState,
//     this.sCountry,
//     this.sLandMark,
//     this.sPincode,
//     this.destinationlatitude,
//     this.destinationlongitude,
//     this.dStreet,
//     this.dCity,
//     this.dState,
//     this.dCountry,
//     this.dPincode,
//     this.distance,
//     this.goodsWeightId,
//     this.goodsTypeId,
//     this.vehicleCategoryId,
//     this.perKm,
//     this.baseFare,
//     this.vehicleId,
//     this.numberofLabours,
//     this.goodsvalue,
//     this.pickUpDateTime,
//     this.consignorName,
//     this.consignorNumber,
//     this.consigneeName,
//     this.consigneeNumber,
//     this.consigneeGst,
//     this.consigneePan,
//     this.bookedGoodsTypes,
//     this.bookingAmount,
//     this.labourCharges,
//     this.labourChargesPerHead,
//     this.totalAmount,
//     this.advCompType,
//     this.paymentMode,
//     this.paymentMethod,
//     this.creationDate,
//     this.modifiedDate,
//     this.status,
//     this.isActive,
//     this.cancelledByCustomer,
//     this.bookedBy,
//     this.bookedItems,
//     this.vehicleImage,
//     this.goodsTypeName,
//     this.goodsWeightName,
//     this.source,
//     this.destination,
//     this.customer,
//     this.fodBy,
//     this.packageDetails,
//     this.supplyType,
//     this.customerFare,
//     this.actualFare,
//     this.offerAmount,
//     this.cgst,
//     this.sgst,
//   });

//   factory BookingDetailsData.fromJson(Map<String, dynamic> json) =>
//       BookingDetailsData(
//         id: json["id"],
//         bookingType: json["bookingType"],
//         referenceId: json["referenceId"],
//         vendorType: json["vendorType"],
//         profileId: json["profileId"],
//         sourcelatitude: json["sourcelatitude"],
//         sourcelongitude: json["sourcelongitude"],
//         sStreet: json["sStreet"],
//         sCity: json["sCity"],
//         sState: json["sState"],
//         sCountry: json["sCountry"],
//         sLandMark: json["sLandMark"],
//         sPincode: json["sPincode"],
//         destinationlatitude: json["destinationlatitude"],
//         destinationlongitude: json["destinationlongitude"],
//         dStreet: json["dStreet"],
//         dCity: json["dCity"],
//         dState: json["dState"],
//         dCountry: json["dCountry"],
//         dPincode: json["dPincode"],
//         distance: json["distance"],
//         goodsWeightId: json["goodsWeightId"],
//         goodsTypeId: json["goodsTypeId"],
//         vehicleCategoryId: json["vehicleCategoryId"],
//         perKm: json["perKm"],
//         baseFare: json["baseFare"],
//         vehicleId: json["vehicleId"],
//         numberofLabours: json["numberofLabours"],
//         goodsvalue: json["goodsvalue"],
//         pickUpDateTime: json["pickUpDateTime"],
//         consignorName: json["consignorName"],
//         consignorNumber: json["consignorNumber"],
//         consigneeName: json["consigneeName"],
//         consigneeNumber: json["consigneeNumber"],
//         consigneeGst: json["consigneeGST"],
//         consigneePan: json["consigneePAN"],
//         bookedGoodsTypes: json["bookedGoodsTypes"],
//         bookingAmount: json["bookingAmount"],
//         labourCharges: json["labourCharges"],
//         labourChargesPerHead: json["labourChargesPerHead"],
//         totalAmount: json["totalAmount"],
//         advCompType: json["advCompType"],
//         paymentMode: json["paymentMode"],
//         paymentMethod: json["paymentMethod"],
//         creationDate: json["creationDate"],
//         modifiedDate: json["modifiedDate"],
//         status: json["status"],
//         isActive: json["isActive"],
//         cancelledByCustomer: json["cancelledByCustomer"],
//         bookedBy: json["bookedBy"],
//         bookedItems: List<dynamic>.from(json["bookedItems"].map((x) => x)),
//         vehicleImage: VehicleImage.fromJson(json["vehicleImage"]),
//         goodsTypeName: GoodsTypeName.fromJson(json["goodsTypeName"]),
//         goodsWeightName: GoodsWeightName.fromJson(json["goodsWeightName"]),
//         source: json["source"],
//         destination: json["destination"],
//         customer: Customer.fromJson(json["customer"]),
//         fodBy: json["fodBy"],
//         packageDetails:
//             List<dynamic>?.from(json["packageDetails"].map((x) => x)),
//         supplyType: json["supplyType"],
//         customerFare: json["customerFare"],
//         actualFare: json["actualFare"],
//         offerAmount: json["offerAmount"],
//         cgst: json["cgst"],
//         sgst: json["sgst"],
//       );
// }

// class Customer {
//   String? firstName;
//   String? lastName;
//   String? mobileNumber;
//   String? emailId;

//   Customer({
//     this.firstName,
//     this.lastName,
//     this.mobileNumber,
//     this.emailId,
//   });

//   factory Customer.fromJson(Map<String, dynamic> json) => Customer(
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         mobileNumber: json["mobileNumber"],
//         emailId: json["emailId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "firstName": firstName,
//         "lastName": lastName,
//         "mobileNumber": mobileNumber,
//         "emailId": emailId,
//       };
// }

// class GoodsTypeName {
//   String? name;
//   dynamic id;

//   GoodsTypeName({
//     this.name,
//     this.id,
//   });

//   factory GoodsTypeName.fromJson(Map<String, dynamic> json) => GoodsTypeName(
//         name: json["name"],
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "id": id,
//       };
// }

// class GoodsWeightName {
//   String? weight;
//   dynamic goodsId;

//   GoodsWeightName({
//     this.weight,
//     this.goodsId,
//   });

//   factory GoodsWeightName.fromJson(Map<String, dynamic> json) =>
//       GoodsWeightName(
//         weight: json["weight"],
//         goodsId: json["goodsId"],
//       );

//   Map<String, dynamic> toJson() => {
//         "weight": weight,
//         "goodsId": goodsId,
//       };
// }

// class VehicleImage {
//   String? path;

//   VehicleImage({
//     this.path,
//   });

//   factory VehicleImage.fromJson(Map<String, dynamic> json) => VehicleImage(
//         path: json["path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "path": path,
//       };
// }

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
  dynamic id;
  String? bookingType;
  String? referenceId;
  String? vendorType;
  String? profileId;
  dynamic sourcelatitude;
  dynamic sourcelongitude;
  String? sStreet;
  String? sCity;
  String? sState;
  String? sCountry;
  String? sLandMark;
  dynamic destinationlatitude;
  dynamic destinationlongitude;
  String? dStreet;
  String? dCity;
  String? dState;
  String? dCountry;
  dynamic dPincode;
  dynamic distance;
  dynamic goodsWeightId;
  dynamic goodsTypeId;
  String? vehicleCategoryId;
  dynamic perKm;
  dynamic baseFare;
  String? vehicleId;
  String? driverId;
  dynamic numberofLabours;
  dynamic goodsvalue;
  dynamic pickUpDateTime;
  String? consignorName;
  String? consignorNumber;
  String? consigneeName;
  String? consigneeNumber;
  String? consigneeGst;
  String? consigneePan;
  dynamic bookedGoodsTypes;
  dynamic bookingAmount;
  dynamic bookingFee;
  dynamic labourCharges;
  dynamic labourChargesPerHead;
  dynamic totalAmount;
  dynamic advCompType;
  dynamic paymentMode;
  dynamic paymentMethod;
  dynamic creationDate;
  dynamic modifiedDate;
  String? status;
  bool? isActive;
  dynamic vehicleImage;
  GoodsTypeName? goodsTypeName;
  GoodsWeightName? goodsWeightName;
  dynamic driverImage;
  String? destination;

  Customer? customer;
  dynamic driver;
  dynamic fodBy;

  dynamic customerFare;
  dynamic actualFare;
  dynamic offerAmount;
  dynamic sgst;
  dynamic cgst;

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
    this.driverId,
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
    this.bookingFee,
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
    this.vehicleImage,
    this.goodsTypeName,
    this.goodsWeightName,
    this.driverImage,
    this.customer,
    this.driver,
    this.fodBy,
    this.customerFare,
    this.actualFare,
    this.offerAmount,
    this.sgst,
    this.cgst,
  });

  factory BookingDetailsData.fromJson(Map<String, dynamic> json) =>
      BookingDetailsData(
        id: json["id"],
        bookingType: json["bookingType"],
        referenceId: json["referenceId"],
        vendorType: json["vendorType"],
        profileId: json["profileId"],
        sourcelatitude: json["sourcelatitude"],
        sourcelongitude: json["sourcelongitude"],
        sStreet: json["sStreet"],
        sCity: json["sCity"],
        sState: json["sState"],
        sCountry: json["sCountry"],
        sLandMark: json["sLandMark"],
        destinationlatitude: json["destinationlatitude"],
        destinationlongitude: json["destinationlongitude"],
        dStreet: json["dStreet"],
        dCity: json["dCity"],
        dState: json["dState"],
        dCountry: json["dCountry"],
        dPincode: json["dPincode"],
        distance: json["distance"],
        goodsWeightId: json["goodsWeightId"],
        goodsTypeId: json["goodsTypeId"],
        vehicleCategoryId: json["vehicleCategoryId"],
        perKm: json["perKm"],
        baseFare: json["baseFare"],
        vehicleId: json["vehicleId"],
        driverId: json["driverId"],
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
        bookingFee: json["bookingFee"],
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
        vehicleImage: json["vehicleImage"],
        goodsTypeName: GoodsTypeName.fromJson(json["goodsTypeName"]),
        goodsWeightName: GoodsWeightName.fromJson(json["goodsWeightName"]),
        driverImage: json["driverImage"],
        customer: Customer.fromJson(json["customer"]),
        driver: json["driver"],
        fodBy: json["fodBy"],
        customerFare: json["customerFare"],
        actualFare: json["actualFare"],
        offerAmount: json["offerAmount"],
        sgst: json["sgst"],
        cgst: json["cgst"],
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
}

// class VehicleImage {
//   String? path;

//   VehicleImage({
//     this.path,
//   });

//   factory VehicleImage.fromJson(Map<String, dynamic> json) => VehicleImage(
//         path: json["path"],
//       );
// }

class GoodsTypeName {
  String? name;
  dynamic id;

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
  dynamic goodsId;

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
