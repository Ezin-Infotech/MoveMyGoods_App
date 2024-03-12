import 'package:flutter/material.dart';
import 'package:mmg/app/bookings/model/booking_model.dart';
import 'package:mmg/app/bookings/services/booking_services.dart';
import 'package:mmg/app/utils/enums.dart';

class BookingProvider with ChangeNotifier {
  TextEditingController sourceController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  TextEditingController goodsTypeController = TextEditingController();
  TextEditingController goodsValueController = TextEditingController();
  TextEditingController numberOfLabourController = TextEditingController();
  TextEditingController goodsWeightController = TextEditingController();
  TextEditingController receiverNameController = TextEditingController();
  TextEditingController receiverEmailController = TextEditingController();
  TextEditingController receiverMobileNoController = TextEditingController();
  TextEditingController receiverRefrenceNumberController =
      TextEditingController();
  TextEditingController receiverLocationController = TextEditingController();
  TextEditingController receiverPanNoController = TextEditingController();
  TextEditingController receiverGstNoController = TextEditingController();
  TextEditingController shipperNameController = TextEditingController();
  TextEditingController shipperemailController = TextEditingController();
  TextEditingController shipperMobileNoController = TextEditingController();
  TextEditingController shipperpanNOController = TextEditingController();
  TextEditingController shipperGstNoController = TextEditingController();
  String selectedOption = 'DOCTOR';

  String selectedStatus = 'booking';
// 'PENDING';
// 'CANCELLED'
// 'COMPLETED'
// 'ACTIVE'

  List<String> lists = [
    'DOCTOR',
    'ENGINEER',
    'DEVELOPER',
    'SOCIALWORK',
    'BUISSINESS',
    'OTHER'
  ];

  /*-------- API SERVICES ------------*/

  BookingServices services = BookingServices();

  /* Dashboard Booking Counts */
  GetBookingStatus getBookingStatus = GetBookingStatus.initial;
  BookingData bookingata = BookingData();
  getBookingByStatusFn() async {
    getBookingStatus = GetBookingStatus.loading;
    // notifyListeners();
    try {
      final countRespose =
          await services.getookingByStatusService(status: selectedStatus);
      print(countRespose.status);
      bookingata = countRespose.data!;
      print(bookingata);

      getBookingStatus = GetBookingStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      print(e);
      getBookingStatus = GetBookingStatus.error;
      notifyListeners();
    }
  }
}
