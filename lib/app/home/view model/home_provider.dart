import 'package:flutter/material.dart';
import 'package:mmg/app/bookings/view/booking_list.dart';
import 'package:mmg/app/home/view/home_screen.dart';

import 'package:mmg/app/settings/view/settings_screen.dart';

class HomeProvider with ChangeNotifier {
  List pageList = [
    // const HomeScreen(),
    // const LoginScreen(),

    const HomeScreen(),

    const BookingListScreen(),
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
}
