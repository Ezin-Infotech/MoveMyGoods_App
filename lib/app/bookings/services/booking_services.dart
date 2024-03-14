import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mmg/app/bookings/model/booking_details_model.dart';
import 'package:mmg/app/bookings/model/booking_model.dart';
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
    print(response);
    return bookingDetailsModelFromJson(jsonEncode(response.data));
  }
}
