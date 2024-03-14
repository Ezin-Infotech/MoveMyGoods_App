import 'package:flutter/material.dart';

import 'package:mmg/app/bookings/view/booking_list.dart';
import 'package:mmg/app/home/model/booking_count_model.dart';
import 'package:mmg/app/home/services/home_services.dart';
import 'package:mmg/app/home/view/home_screen.dart';

import 'package:mmg/app/settings/view/settings_screen.dart';
import 'package:mmg/app/utils/enums.dart';

class HomeProvider with ChangeNotifier {
  List pageList = [
    // const HomeScreen(),
    // const LoginScreen(),

    const HomeScreen(),
    const BookingListScreen(),
    // const CompletedBookingScreen(),

    // const BookingScreen(),
    // const BookingListScreen(),
    const SettingsScreen(),
  ];
  int curentIndex = 0;

  changeCurrentIndex(int index) {
    curentIndex = index;
    notifyListeners();
  }

  List<String> bookingTiltes = [
    'All bookings',
    'Bookings',
    'Pending',
    'Active',
    'Completed',
    'Cancelled',
  ];

  /*-------- API SERVICES ------------*/

  HomeServices services = HomeServices();

  /* Dashboard Booking Counts */
  GetAllBookingCountStatus getAllBookingCountStatus =
      GetAllBookingCountStatus.initial;
  DashboardBookingCountModel bookingCountData = DashboardBookingCountModel();
  getBookingCountFn() async {
    getAllBookingCountStatus = GetAllBookingCountStatus.loading;
    try {
      final countRespose = await services.dashboardBookingCountService();

      bookingCountData = countRespose;

      getAllBookingCountStatus = GetAllBookingCountStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      getAllBookingCountStatus = GetAllBookingCountStatus.error;
      notifyListeners();
    }
  }
}
