import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mmg/app/home/model/booking_count_model.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/backend/urls.dart';

class HomeServices extends Urls {
  /* Dashboard Booking Count */
  Future<DashboardBookingCountModel> dashboardBookingCountService() async {
    print(
        'reached $bookingCount/${AppPref.userProfileId}    --- ${AppPref.userToken}');
    final response = await dio.get('$bookingCount/${AppPref.userProfileId}',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));

    print("dashboardBookingCountService: $response");
    return dashboardBookingCountModelFromJson(jsonEncode(response.data));
  }
}
