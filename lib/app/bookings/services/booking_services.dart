import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mmg/app/bookings/model/booking_model.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/backend/urls.dart';

class BookingServices extends Urls {
  /* Dashboard Booking Count */
  Future<BookingModel> getookingByStatusService(
      {required String status}) async {
    print('reached $bookingByStatus/$status/customer/${AppPref.userProfileId}');
    final response = await dio.get(
        '$bookingByStatus/$status/customer/${AppPref.userProfileId}',
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
}
