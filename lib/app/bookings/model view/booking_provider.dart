import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
import 'package:map_picker/map_picker.dart';
import 'package:flutter/widgets.dart';
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
  String tempSelectedStatus = 'All';
// 'PENDING';
// 'CANCELLED'
// 'COMPLETED'
// 'ACTIVE'

  List<String> lists = [
    'DOCTOR',
    'ENGINEER',
    'DEVELOPER',
    'SOCIALWORK',
    'BUSINESS',
    'OTHER'
  ];

  filterFunction({required String status, required BuildContext context}) {
    tempSelectedStatus = status;
    notifyListeners();
    if (status.toLowerCase() == 'all') {
      selectedStatus = 'booking';
      getAllBookingByStatusFn();
    } else {
      selectedStatus = status.toUpperCase();
      getBookingByStatusFn();
    }
    Navigator.pop(context);
  }

  /*-------- API SERVICES ------------*/

  BookingServices services = BookingServices();

  /* Dashboard Booking Counts */
  GetBookingStatus getBookingStatus = GetBookingStatus.initial;
  BookingData bookingata = BookingData();
  getAllBookingByStatusFn() async {
    getBookingStatus = GetBookingStatus.loading;
    // notifyListeners();
    try {
      final countRespose = await services.getAllBookingsService();
      bookingata = countRespose.data!;

      getBookingStatus = GetBookingStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      getBookingStatus = GetBookingStatus.error;
      notifyListeners();
    }
  }

  getBookingByStatusFn() async {
    getBookingStatus = GetBookingStatus.loading;
    // notifyListeners();
    try {
      final countRespose =
          await services.getBookingsByStatusService(status: selectedStatus);
      bookingata = countRespose.data!;

      getBookingStatus = GetBookingStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      getBookingStatus = GetBookingStatus.error;
      notifyListeners();
    }
  }

  // final controller = Completer<GoogleMapController>();
  // MapPickerController mapPickerController = MapPickerController();
  // CameraPosition cameraPosition = const CameraPosition(
  //   target: LatLng(0.00, 0.00),
  //   zoom: 14.4746,
  // );
  // Location location = Location();
  // bool serviceEnabled = false;
  // PermissionStatus permissionGranted = PermissionStatus.denied;
  // LocationData? locationData;

  // Future<void> checkLocationPermission() async {
  //   serviceEnabled = await location.serviceEnabled();
  //   if (!serviceEnabled) {
  //     serviceEnabled = await location.requestService();
  //     if (!serviceEnabled) {
  //       return;
  //     }
  //   }

  //   permissionGranted = await location.hasPermission();
  //   if (permissionGranted == PermissionStatus.denied) {
  //     permissionGranted = await location.requestPermission();
  //     if (permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   locationData = await location.getLocation();
  //   LatLng currentLocation = LatLng(
  //     locationData?.latitude ?? 0.00,
  //     locationData?.longitude ?? 0.00,
  //   );
  //   cameraPosition = CameraPosition(
  //     target: currentLocation,
  //     zoom: 14.4746,
  //   );
  //   notifyListeners();
  // }
}
