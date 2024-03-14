// To parse this JSON data, do
//
//     final bookingFarePriceDetailsModel = bookingFarePriceDetailsModelFromJson(jsonString);

import 'dart:convert';

BookingFarePriceDetailsModel bookingFarePriceDetailsModelFromJson(String str) =>
    BookingFarePriceDetailsModel.fromJson(json.decode(str));

class BookingFarePriceDetailsModel {
  String? status;
  BookingFarePriceData? data;

  BookingFarePriceDetailsModel({
    this.status,
    this.data,
  });

  factory BookingFarePriceDetailsModel.fromJson(Map<String, dynamic> json) =>
      BookingFarePriceDetailsModel(
        status: json["status"],
        data: BookingFarePriceData.fromJson(json["data"]),
      );
}

class BookingFarePriceData {
  num? distance;
  num? perKm;
  num? baseFare;
  num? numberofLabours;
  num? bookingAmount;
  num? bookingFee;
  num? labourCharges;
  num? labourChargesPerHead;
  num? totalAmount;
  String? supplyType;
  num? actualFare;
  num? offerAmount;
  num? sgst;
  num? cgst;

  BookingFarePriceData({
    this.distance,
    this.perKm,
    this.baseFare,
    this.numberofLabours,
    this.bookingAmount,
    this.bookingFee,
    this.labourCharges,
    this.labourChargesPerHead,
    this.totalAmount,
    this.supplyType,
    this.actualFare,
    this.offerAmount,
    this.sgst,
    this.cgst,
  });

  factory BookingFarePriceData.fromJson(Map<String, dynamic> json) =>
      BookingFarePriceData(
        distance: json["distance"],
        perKm: json["perKm"],
        baseFare: json["baseFare"],
        numberofLabours: json["numberofLabours"],
        bookingAmount: json["bookingAmount"],
        bookingFee: json["bookingFee"],
        labourCharges: json["labourCharges"],
        labourChargesPerHead: json["labourChargesPerHead"],
        totalAmount: json["totalAmount"],
        supplyType: json["supplyType"],
        actualFare: json["actualFare"],
        offerAmount: json["offerAmount"],
        sgst: json["sgst"],
        cgst: json["cgst"],
      );
}
