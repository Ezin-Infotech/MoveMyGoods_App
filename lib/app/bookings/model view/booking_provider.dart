import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:location/location.dart';
import 'package:mmg/app/bookings/model/booking_details_model.dart';
import 'package:mmg/app/bookings/model/booking_fare_price_details_model.dart';
import 'package:mmg/app/bookings/model/booking_model.dart';
import 'package:mmg/app/bookings/model/booking_weight_model.dart';
import 'package:mmg/app/bookings/model/goods_type_model.dart';
import 'package:mmg/app/bookings/model/vehicle_details_model.dart';
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
  bool showRecieverDetails = false;
  bool showPriceDetails = false;
  bool showGoodsWeight = false;
  bool showVehicleImage = false;
  bool showFarePrice = false;
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

  List<String> reciptContent = [
    'DOCTOR',
    'ENGINEER',
    'DEVELOPER',
    'SOCIALWORK',
    'BUISSINESS',
    'OTHER'
  ];

  List<String> goodsWight = ['100', '200', '300', '400', '500', '750'];
  changeShowRecieverDetails({required bool isShow}) {
    showRecieverDetails = isShow;
    notifyListeners();
  }

  changeShowPriceDetails({required bool isShow}) {
    showPriceDetails = isShow;
    notifyListeners();
  }

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

  filterFromHomeFunction(
      {required String status, required BuildContext context}) {
    tempSelectedStatus = status;
    notifyListeners();
    if (status.toLowerCase() == 'all') {
      selectedStatus = 'booking';
      getAllBookingByStatusFn();
    } else {
      selectedStatus = status.toUpperCase();
      getBookingByStatusFn();
    }
  }

  /*-------- API SERVICES ------------*/

  BookingServices services = BookingServices();

  /* Dashboard Booking Counts */
  GetBookingDetialsStatus getBookingDetailStatus =
      GetBookingDetialsStatus.initial;
  BookingDetailsModel bookingDetail = BookingDetailsModel();
  getBookingDetailsByIdFn({required String id}) async {
    getBookingDetailStatus = GetBookingDetialsStatus.loading;
    // notifyListeners();
    try {
      final countRespose = await services.getBookingDetailsByIdService(id: id);
      bookingDetail = countRespose;
      print(bookingDetail);
      getBookingDetailStatus = GetBookingDetialsStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      print('bookingDetail $e');
      getBookingDetailStatus = GetBookingDetialsStatus.error;
      notifyListeners();
    }
  }

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

/* Dashboard Booking Counts */
  GetGoodsTypeStatus getGoodsTypeStatus = GetGoodsTypeStatus.initial;
  GoodsTypData goodsTypeData = GoodsTypData();
  getGoodsTypeFn() async {
    getGoodsTypeStatus = GetGoodsTypeStatus.loading;
    // notifyListeners();
    try {
      final goodsResponse = await services.getGoodsTypeService();
      goodsTypeData = goodsResponse.data!;
      print(bookingDetail);
      getGoodsTypeStatus = GetGoodsTypeStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      print('bookingDetail $e');
      getGoodsTypeStatus = GetGoodsTypeStatus.error;
      notifyListeners();
    }
  }

  clearBooingVariables() {
    goodsWeightId = '';
    goodsTypeId = '';
    goodsTypeController.clear();
    sourceController.clear();
    destinationController.clear();
    goodsTypeController.clear();
    goodsValueController.clear();
    numberOfLabourController.clear();
    goodsWeightController.clear();
    receiverNameController.clear();
    receiverEmailController.clear();
    receiverMobileNoController.clear();
    receiverRefrenceNumberController.clear();
    receiverLocationController.clear();
    receiverPanNoController.clear();
    receiverGstNoController.clear();
    shipperNameController.clear();
    shipperemailController.clear();
    shipperMobileNoController.clear();
    shipperpanNOController.clear();
    shipperGstNoController.clear();

    showRecieverDetails = false;
    showPriceDetails = false;
    showGoodsWeight = false;
    showVehicleImage = false;
    showFarePrice = false;
  }

  String goodsWeightId = '';
  String goodsTypeId = '';
  changeGoodsTypeController({required String id, required String value}) {
    goodsTypeController.clear();
    goodsTypeController.text = value;
    goodsTypeId = id;
    notifyListeners();
    if (goodsWeightId != '') {
      getGoodsVehicleDetailsFn();
    }
    getGoodsWeightFn();
    print(goodsTypeController.text);
  }

  changeGoodsWeight({required String id}) {
    goodsWeightId = id;
    getGoodsVehicleDetailsFn();
    notifyListeners();
    print(goodsWeightId);
  }

  changeGoodsWeightFn({required bool isShow}) {
    showGoodsWeight = isShow;
    notifyListeners();
  }

  changeVehicleImageFn({required bool isShow}) {
    showVehicleImage = isShow;
    notifyListeners();
  }

  changeFarePriceFn({required bool isShow}) {
    showFarePrice = isShow;
    notifyListeners();
  }

  GetGoodsWeightStatus getGoodsWeightStatus = GetGoodsWeightStatus.initial;
  GoodsWeightData goodsWeightData = GoodsWeightData();
  getGoodsWeightFn() async {
    getGoodsWeightStatus = GetGoodsWeightStatus.loading;
    // notifyListeners();
    try {
      final goodsResponse = await services.getGoodsWeightService(data: {
        "sourcelatitude": 12.2958104,
        "sourcelongitude": 76.6393805,
        "destinationlatitude": 12.2544597,
        "destinationlongitude": 76.7170574,
        "sCountry": "India",
        "sState": "Karnataka",
        "sCity": "Mysore Division"
      });
      goodsWeightData = goodsResponse.data!;
      print(bookingDetail);
      getGoodsWeightStatus = GetGoodsWeightStatus.loaded;
      showGoodsWeight = true;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      print('bookingDetail $e');
      getGoodsWeightStatus = GetGoodsWeightStatus.error;
      notifyListeners();
    }
  }

  GetGoodsVehicleStatus getGoodsVehicleStatus = GetGoodsVehicleStatus.initial;
  GoodsVehicleDetailsModel goodsVehicleDetailsModel =
      GoodsVehicleDetailsModel();
  getGoodsVehicleDetailsFn() async {
    getGoodsVehicleStatus = GetGoodsVehicleStatus.loading;
    // notifyListeners();
    try {
      final goodsResponse = await services.getGoodsVehicleDetailsService(
          goodsTypeId: int.parse(goodsTypeId),
          kerbWeightId: int.parse(goodsWeightId),
          latitude: 12.2958104,
          longitude: 76.6393805);
      goodsVehicleDetailsModel = goodsResponse;
      print(goodsVehicleDetailsModel);
      getGoodsVehicleStatus = GetGoodsVehicleStatus.loaded;
      showVehicleImage = true;
      getBookingFarePriceFn();
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      print('bookingDetail $e');
      getGoodsVehicleStatus = GetGoodsVehicleStatus.error;
      notifyListeners();
    }
  }

  GetBookingFarePriceStatus getBookingFarePriceStatus =
      GetBookingFarePriceStatus.initial;
  BookingFarePriceDetailsModel bookingFarePriceDetailsModel =
      BookingFarePriceDetailsModel();
  getBookingFarePriceFn() async {
    getBookingFarePriceStatus = GetBookingFarePriceStatus.loading;
    // notifyListeners();
    try {
      final goodsResponse = await services.getBookingFarePriceService(data: {
        "sourcelatitude": 12.2544597,
        "sourcelongitude": 76.7170574,
        "destinationlatitude": 12.2958104,
        "destinationlongitude": 76.6393805,
        "vehicleCategoryId":
            goodsVehicleDetailsModel.data![0].vehicleCategoryId,
        "sCountry": "India",
        "sState": "Karnataka",
        "sCity": "Mysore Division",
        "referenceId": "",
        "vendorType": goodsVehicleDetailsModel.data![0].vendorType,
        "profileId": "b0270f1e-bed8-47cb-b490-662f9f4b51ff",
        "goodsvalue": int.parse(goodsValueController.text),
        "numberofLabours": int.parse(numberOfLabourController.text == ''
            ? '0'
            : numberOfLabourController.text),
        "goodsWeighId": int.parse(goodsWeightId),
        "totalNoOfTon": "",
        "goodsTypeId": int.parse(goodsTypeId),
      });
      bookingFarePriceDetailsModel = goodsResponse;
      print(bookingFarePriceDetailsModel);
      getBookingFarePriceStatus = GetBookingFarePriceStatus.loaded;
      showFarePrice = true;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      print('bookingDetail $e');
      getBookingFarePriceStatus = GetBookingFarePriceStatus.error;
      notifyListeners();
    }
  }

  // GOOGLE MAP INTEGRATION

  // Future<LatLng> getLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error('Location permissions are permanently denied');
  //   }
  //   Position position = await Geolocator.getCurrentPosition();
  //   return LatLng(position.latitude, position.longitude);
  // }

  final String _apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';
  final String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  List<PlaceSuggestion> searchResults = [];
  List<PlaceSuggestion> destinationSearchResults = [];

  Future<void> searchLocation({
    required String query,
    required bool dest,
  }) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/autocomplete/json',
        queryParameters: {
          'input': query,
          'types': '(cities)',
          'key': _apiKey,
        },
      );
      if (response.statusCode == 200) {
        if (dest) {
          destinationSearchResults = [];
          for (var place in response.data['predictions']) {
            destinationSearchResults.add(
              PlaceSuggestion(
                name: place['description'],
                placeId: place['place_id'],
              ),
            );
          }
        } else {
          searchResults = [];
          for (var place in response.data['predictions']) {
            searchResults.add(
              PlaceSuggestion(
                name: place['description'],
                placeId: place['place_id'],
              ),
            );
          }
        }
        notifyListeners();
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<LatLng> getPlaceDetails(String placeId) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final location = response.data['result']['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      } else {
        throw Exception("Failed to load place details");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

class PlaceSuggestion {
  String name;
  String placeId;

  PlaceSuggestion({required this.name, required this.placeId});
}
