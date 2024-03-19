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

  List<GlobalKey> globalKeys = [];

  final GlobalKey globalKey1 = GlobalKey();
  final GlobalKey globalKey2 = GlobalKey();
  final GlobalKey globalKey3 = GlobalKey();
  final GlobalKey globalKey4 = GlobalKey();
  final GlobalKey globalKey5 = GlobalKey();
  final GlobalKey globalKey6 = GlobalKey();
  final GlobalKey globalKey7 = GlobalKey();
  final GlobalKey globalKey8 = GlobalKey();
  final GlobalKey globalKey9 = GlobalKey();
  final GlobalKey globalKey10 = GlobalKey();
  final GlobalKey globalKey11 = GlobalKey();
  final GlobalKey globalKey12 = GlobalKey();
  final GlobalKey globalKey13 = GlobalKey();
  final GlobalKey globalKey14 = GlobalKey();
  final GlobalKey globalKey15 = GlobalKey();
  final GlobalKey globalKey16 = GlobalKey();
  final GlobalKey globalKey17 = GlobalKey();
  final GlobalKey globalKey18 = GlobalKey();

  List<String> descriptions = [
    'Welcome to your digital hub! Our app home is your gateway to seamless navigation',
    'You can connect\n your watch',
    'Unlock exclusive rewards with our loyalty tier system',
    'Your virtual shopping companion awaits',
    'Meet your new virtual assistant.You can chat with us',
    'Meet your new virtual assistant.You can chat with us',
  ];

  List<String> descriptions1 = [
    'Welcome to your digital hub! Our app home is your gateway to seamless navigation',
    'You can connect\n your watch',
    'Unlock exclusive rewards with our loyalty tier system',
    'Your virtual shopping companion awaits',
    'Meet your new virtual assistant.You can chat with us',
    'Meet your new virtual assistant.You can chat with us',
    'Meet your new virtual assistant.You can chat with us',
    'Meet your new virtual assistant.You can chat with us',
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
      print('dashboardBookingCountService reached');
      final countRespose = await services.dashboardBookingCountService();

      bookingCountData = countRespose;

      getAllBookingCountStatus = GetAllBookingCountStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      print('dashboardBookingCountService $e');
      getAllBookingCountStatus = GetAllBookingCountStatus.error;
      notifyListeners();
    }
  }
}
