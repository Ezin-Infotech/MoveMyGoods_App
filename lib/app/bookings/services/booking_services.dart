import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mmg/app/bookings/model/booking_details_model.dart';
import 'package:mmg/app/bookings/model/booking_fare_price_details_model.dart';
import 'package:mmg/app/bookings/model/booking_model.dart';
import 'package:mmg/app/bookings/model/booking_weight_model.dart';
import 'package:mmg/app/bookings/model/goods_type_model.dart';
import 'package:mmg/app/bookings/model/vehicle_details_model.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/backend/urls.dart';

class BookingServices extends Urls {
  /* Dashboard Booking Count */
  Future<BookingModel> getAllBookingsService() async {
    final response = await dio.get(
        '$bookingByStatus/booking/customer/${AppPref.userProfileId}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    // print(response);
    return bookingModelFromJson(jsonEncode(response.data));
  }

  Future<BookingModel> getBookingsByStatusService(
      {required String status}) async {
    final response = await dio.get(
        '$bookingByStatus/booking/status/$status/customer/${AppPref.userProfileId}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    // print(response);
    return bookingModelFromJson(jsonEncode(response.data));
  }

  Future<BookingDetailsModel> getBookingDetailsByIdService(
      {required String id}) async {
    final response = await dio.get('$bookingDetails/$id',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    return bookingDetailsModelFromJson(jsonEncode(response.data));
  }

  Future<GoodsTypeModel> getGoodsTypeService() async {
    final response = await dio.get(goodsTypeUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    if (kDebugMode) {
      print("GOODS RESPOnsE = $response");
    }
    return goodsTypeModelFromJson(jsonEncode(response.data));
  }

  Future<GoodsWeightModel> getGoodsWeightService(
      {required dynamic data}) async {
    print('Goods Weight Response  $data');
    try {
      final response = await dio.post(goodsWeightUrl,
          data: data,
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${AppPref.userToken}',
              'x-api-key': 'MMGATPL'
            },
          ));

      print('Goods Weight Response  $response');
      return goodsWeightModelFromJson(jsonEncode(response.data));
    } catch (e) {
      print('Goods Weight Response  $e');
      return GoodsWeightModel();
    }
  }

  Future<GoodsVehicleDetailsModel> getGoodsVehicleDetailsService(
      {required int goodsTypeId,
      required int kerbWeightId,
      required dynamic latitude,
      required dynamic longitude}) async {
    final response = await dio.get(
        '$goodsVehicleUrl/latitude/$latitude/longitude/$longitude',
        queryParameters: {
          "goodsTypeId": goodsTypeId,
          "kerbWeightId": kerbWeightId,
          "role": 1,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    return goodsVehicleDetailsModelFromJson(jsonEncode(response.data));
  }

  Future<BookingFarePriceDetailsModel> getBookingFarePriceService(
      {required dynamic data}) async {
    final response = await dio.post(bookingFarePriceUrl,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    return bookingFarePriceDetailsModelFromJson(jsonEncode(response.data));
  }

  Future postConfirmBookingService({required dynamic data}) async {
    print('Goods Weight Response  $data');
    final response = await dio.post(confirmBookingUrl,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    return response.data;
  }

  Future cancelBookingService({required String bookingId}) async {
    final response = await dio.put(
        "$cancelBookingUrl/CANCELLED/booking/$bookingId/profile/${AppPref.userProfileId}/role/9",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    return response.data;
  }
}
