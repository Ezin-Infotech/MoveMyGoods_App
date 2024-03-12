// To parse this JSON data, do
//
//     final dashboardBookingCountModel = dashboardBookingCountModelFromJson(jsonString);

import 'dart:convert';

DashboardBookingCountModel dashboardBookingCountModelFromJson(String str) =>
    DashboardBookingCountModel.fromJson(json.decode(str));

class DashboardBookingCountModel {
  String? status;
  Data? data;

  DashboardBookingCountModel({
    this.status,
    this.data,
  });

  factory DashboardBookingCountModel.fromJson(Map<String, dynamic> json) =>
      DashboardBookingCountModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  int? total;
  int? pending;
  int? completed;
  int? active;
  int? cancelled;
  int? quotation;

  Data({
    this.total,
    this.pending,
    this.completed,
    this.active,
    this.cancelled,
    this.quotation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
        pending: json["pending"],
        completed: json["completed"],
        active: json["active"],
        cancelled: json["cancelled"],
        quotation: json["quotation"],
      );
}
