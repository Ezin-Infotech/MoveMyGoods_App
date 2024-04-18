// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
// import 'package:location/location.dart';
import 'package:mmg/app/bookings/model/booking_details_model.dart';
import 'package:mmg/app/bookings/model/booking_fare_price_details_model.dart';
import 'package:mmg/app/bookings/model/booking_model.dart';
import 'package:mmg/app/bookings/model/booking_weight_model.dart';
import 'package:mmg/app/bookings/model/goods_type_model.dart';
import 'package:mmg/app/bookings/model/vehicle_details_model.dart';
import 'package:mmg/app/bookings/services/booking_services.dart';
import 'package:mmg/app/bookings/services/pdf_download.dart';
import 'package:mmg/app/home/view%20model/home_provider.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/common%20widgets/dialogs.dart';
import 'package:mmg/app/utils/common%20widgets/loading_overlay.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

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
    print(id);
    getBookingDetailStatus = GetBookingDetialsStatus.loading;
    // notifyListeners();
    try {
      final countResponse = await services.getBookingDetailsByIdService(id: id);
      bookingDetail = countResponse;
      getBookingDetailStatus = GetBookingDetialsStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
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
      final countResponse = await services.getAllBookingsService();
      bookingata = countResponse.data!;

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
      final countResponse =
          await services.getBookingsByStatusService(status: selectedStatus);
      bookingata = countResponse.data!;

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
      getGoodsTypeStatus = GetGoodsTypeStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
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
    goodsWeightId = '';
    goodsTypeId = '';
    sourceLatitude = 0;
    sourceLongitude = 0;
    destinationLatitude = 0;
    destinationLongitude = 0;
    vehicleCategoryId = 0;
    sStreet = '';
    sCity = '';
    sState = '';
    sCountry = '';
    sLandMark = '';
    dStreet = '';
    dCity = '';
    dState = '';
    dCountry = '';
    sPincode = '';
    dPincode = '';
    billingId = 1;
  }

  setShipperDetails({
    required String name,
    required String mobile,
    required String gstNumber,
  }) {
    shipperNameController = TextEditingController(text: name);

    shipperMobileNoController = TextEditingController(text: mobile);

    shipperGstNoController = TextEditingController(text: gstNumber);
    notifyListeners();
  }

  setBillingId({required int value}) {
    billingId = value;
    notifyListeners();
  }

  int billingId = 1;

  String goodsWeightId = '';
  int goodsWeightIndex = -1;
  String goodsTypeId = '';
  changeGoodsTypeController({required String id, required String value}) {
    goodsTypeController.clear();
    goodsTypeController.text = value;
    goodsTypeId = id;
    print('Goods Weight Response $goodsTypeId');
    getGoodsWeightFn();

    if (goodsWeightId != '') {
      getGoodsVehicleDetailsFn();
    }
    notifyListeners();
  }

  changeGoodsWeight({required String id, required int index}) {
    goodsWeightIndex = index;
    log("changeGoodsWeight: $id");
    goodsWeightId = id;
    getGoodsVehicleDetailsFn();
    notifyListeners();
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
      print('Goods Weight Response winning');
      final goodsResponse = await services.getGoodsWeightService(data: {
        "sourcelatitude": sourceLatitude,
        "sourcelongitude": sourceLongitude,
        "destinationlatitude": destinationLatitude,
        "destinationlongitude": destinationLongitude,
        "sCountry": sCountry,
        "sState": sState,
        "sCity": sCity
      });
      print('Goods Weight Response $goodsWeightData');
      goodsWeightData = goodsResponse.data!;
      getGoodsWeightStatus = GetGoodsWeightStatus.loaded;
      showGoodsWeight = true;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
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
      getGoodsVehicleStatus = GetGoodsVehicleStatus.loaded;
      showVehicleImage = true;
      getBookingFarePriceFn();
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
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
        "sourcelatitude": sourceLatitude,
        "sourcelongitude": sourceLongitude,
        "destinationlatitude": destinationLatitude,
        "destinationlongitude": destinationLongitude,
        "vehicleCategoryId":
            goodsVehicleDetailsModel.data![0].vehicleCategoryId,
        "sCountry": sCountry,
        "sState": sState,
        "sCity": sCity,
        "referenceId": goodsVehicleDetailsModel.data![0].vendorId,
        "vendorType": goodsVehicleDetailsModel.data![0].vendorType,
        "profileId": AppPref.userProfileId,
        "goodsvalue": int.parse(goodsValueController.text),
        "numberofLabours": int.parse(numberOfLabourController.text == ''
            ? '0'
            : numberOfLabourController.text),
        "goodsWeighId": int.parse(goodsWeightId),
        "totalNoOfTon": "",
        "goodsTypeId": int.parse(goodsTypeId),
      });
      bookingFarePriceDetailsModel = goodsResponse;
      getBookingFarePriceStatus = GetBookingFarePriceStatus.loaded;
      showFarePrice = true;
      notifyListeners();
      // ignore: deprecated_member_use
    } catch (e) {
      getBookingFarePriceStatus = GetBookingFarePriceStatus.error;
      notifyListeners();
    }
  }

  // GOOGLE MAP INTEGRATION

  Future<LatLng> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition();

    return LatLng(position.latitude, position.longitude);
  }

  final String _apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';
  final String _baseUrl = 'https://maps.googleapis.com/maps/api/place';
  List<PlaceSuggestion> searchResults = [];
  List<PlaceSuggestion> destinationSearchResults = [];

  Future<void> searchLocation({
    required String query,
    required bool dest,
  }) async {
    try {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&components=country:IN&key=$_apiKey';
      final response = await Dio().get(
        url,
        // '$_baseUrl/autocomplete/json',
        // queryParameters: {
        //   'input': query,
        //   // 'types': '(cities)',
        //   'key': _apiKey,
        // },
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

  Future<LatLng> getPlaceDetails(
    String placeId,
    BuildContext context,
    bool isSource,
  ) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry,address_components,formatted_address',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final location = response.data['result']['geometry']['location'];
        if (isSource) {
          sourceLatitude = double.parse(location['lat'].toString());
          sourceLongitude = double.parse(location['lng'].toString());
        } else {
          destinationLatitude = location['lat'];
          destinationLongitude = location['lng'];
        }

        if (isSource) {
          sStreet = response.data["result"]["formatted_address"];

          for (int i = 0;
              i < response.data["result"]["address_components"].length;
              i++) {
            if (response.data["result"]["address_components"][i]["types"]
                .contains("administrative_area_level_2")) {
              sCity =
                  response.data["result"]["address_components"][i]["long_name"];
            } else if (response.data["result"]["address_components"][i]["types"]
                .contains("administrative_area_level_1")) {
              sState =
                  response.data["result"]["address_components"][i]["long_name"];
            } else if (response.data["result"]["address_components"][i]["types"]
                .contains("country")) {
              sCountry =
                  response.data["result"]["address_components"][i]["long_name"];
            } else if (response.data["result"]["address_components"][i]["types"]
                .contains("neighborhood")) {
              sLandMark =
                  response.data["result"]["address_components"][i]["long_name"];
            } else if (response.data["result"]["address_components"][i]["types"]
                .contains("postal_code")) {
              sPincode = response.data["result"]["address_components"][i]
                  ["long_name"][0];
            }
          }

          // sStreet = data["formatted_address"];
        } else {
          dStreet = response.data["result"]["formatted_address"];

          for (int i = 0;
              i < response.data["result"]["address_components"].length;
              i++) {
            if (response.data["result"]["address_components"][i]["types"]
                .contains("administrative_area_level_2")) {
              dCity =
                  response.data["result"]["address_components"][i]["long_name"];
            } else if (response.data["result"]["address_components"][i]["types"]
                .contains("administrative_area_level_1")) {
              dState =
                  response.data["result"]["address_components"][i]["long_name"];
            } else if (response.data["result"]["address_components"][i]["types"]
                .contains("country")) {
              dCountry =
                  response.data["result"]["address_components"][i]["long_name"];
            } else if (response.data["result"]["address_components"][i]["types"]
                .contains("postal_code")) {
              dPincode = response.data["result"]["address_components"][i]
                  ["long_name"][0];
            }
          }
        }

        return LatLng(location['lat'], location['lng']);
      } else {
        throw Exception("Failed to load place details");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //Booking Variables

  num sourceLatitude = 0;
  num sourceLongitude = 0;
  num destinationLatitude = 0;
  num destinationLongitude = 0;
  num vehicleCategoryId = 0;
  String sStreet = '';
  String sCity = '';
  String sState = '';
  String sCountry = '';
  String sLandMark = '';
  String dStreet = '';
  String dCity = '';
  String dState = '';
  String dCountry = '';
  String sPincode = '';
  String dPincode = '';

  ConfirmBookingStatus confirmBookingStatus = ConfirmBookingStatus.initial;
  confirmBookingFn({required BuildContext context}) async {
    confirmBookingStatus = ConfirmBookingStatus.loading;
    LoadingOverlayDark.of(context).show();
    // notifyListeners();
    try {
      final confirmBookingResponse =
          await services.postConfirmBookingService(data: {
        "sourcelatitude": sourceLatitude,
        "sourcelongitude": sourceLongitude,
        "destinationlatitude": destinationLatitude,
        "destinationlongitude": destinationLongitude,
        "vehicleCategoryId":
            goodsVehicleDetailsModel.data![0].vehicleCategoryId,
        "sStreet": sStreet,
        "sCity": sCity,
        "sState": sState,
        "sCountry": sCountry,
        "sLandMark": sLandMark,
        "sPincode": sPincode,
        "referenceId": goodsVehicleDetailsModel.data![0].vendorId,
        "vendorType": goodsVehicleDetailsModel.data![0].vendorType,
        "profileId": AppPref.userProfileId,
        "goodsvalue": goodsValueController.text,
        "labourCharges": bookingFarePriceDetailsModel.data!.labourCharges,
        "ewayBillNo": "",
        "ewayBillDate": "",
        "numberofLabours": 0,
        "vehicleId": goodsVehicleDetailsModel.data![0].vehicleId,
        "pickUpDateTime": 1710761005194,
        "goodsTypeId": goodsTypeId,
        "status": "PENDING",
        "goodsWeightId": goodsWeightId,
        "fodBy": 1, // Default 1
        "advCompType": 2, // default 2
        "paymentMode": 1, //1 cash 2 means online
        "dStreet": dStreet,
        "dCity": dCity,
        "dState": dState,
        "dCountry": dCountry,
        "dPincode": dPincode,
        "consignorName": shipperNameController.text,
        "consignorNumber": shipperMobileNoController.text,
        "consigneeName": receiverNameController.text,
        "consigneeNumber": receiverMobileNoController.text,
        "consigneeGST": "",
        "consigneePAN": "",
        "bookedGoodsTypes": 1,
        "bookedItems": [],
        "bookingType": "",
        "totalNoOfTon": "",
        "bookedSource": "Web",
        "bookedBy": "CUSTOMER"
      });
      log(confirmBookingResponse["data"]["id"].toString());
      LoadingOverlayDark.of(context).hide();
      getBookingDetailsByIdFn(
          id: confirmBookingResponse["data"]["id"].toString());
      Get.back();
      Get.toNamed(AppRoutes.bookingSuccessFullyCompletedScreen);

      confirmBookingStatus = ConfirmBookingStatus.loaded;
      notifyListeners();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      LoadingOverlayDark.of(context).hide();
      confirmBookingStatus = ConfirmBookingStatus.error;
      notifyListeners();
      errorBottomSheetDialogs(
        isDismissible: false,
        enableDrag: false,
        context: context,
        title: '${e.response!.data['message']}',
        subtitle: '',
      );
    }
  }

  clearBookingList() {
    bookingata = BookingData();
    notifyListeners();
  }

  cancelBookingFn({
    required BuildContext context,
    required String id,
  }) async {
    LoadingOverlayDark.of(context).show();
    // notifyListeners();
    try {
      final confirmBookingResponse =
          await services.cancelBookingService(bookingId: id);

      LoadingOverlayDark.of(context).hide();

      print(confirmBookingResponse);
      successtoast(title: 'Your Booking is cancelled');

      context.read<HomeProvider>().getBookingCountFn();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      notifyListeners();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      LoadingOverlayDark.of(context).hide();
      notifyListeners();
      errorBottomSheetDialogs(
        isDismissible: false,
        enableDrag: false,
        context: context,
        title: '${e.response!.data['message']}',
        subtitle: '',
      );
    }
  }

  Uint8List? bytes;

  downloadBookingInvoiceFn({
    required BuildContext context,
    required String id,
  }) async {
    // LoadingOverlayDark.of(context).show();
    // notifyListeners();
    try {
      log('711950406874');
      final response = await HttpServerClient.get();
      log('$response ----------------------------');
      bytes = bytes;
      log(bytes.toString());
      notifyListeners();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.toString());
      LoadingOverlayDark.of(context).hide();
      notifyListeners();
      errorBottomSheetDialogs(
        isDismissible: false,
        enableDrag: false,
        context: context,
        title: '${e.response!.data['message']}',
        subtitle: '',
      );
    }
  }

  String _pdfPath = '';
  Future<void> fetchPdfData({required String id}) async {
    log("PDF VIEWER message");
    final response = await http.get(
        Uri.parse(
            'http://103.160.153.57:8087/mmg/api/v2/downloadInvoice/booking/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppPref.userToken}',
          'x-api-key': 'MMGATPL'
        });

    log("PDF VIEWER ${response.bodyBytes}");
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/invoice.pdf");
    await file.writeAsBytes(response.bodyBytes);
    _pdfPath = file.path;
    await OpenFile.open(_pdfPath);

    log("PDF VIEWER $_pdfPath");
  }
}

class PlaceSuggestion {
  String name;
  String placeId;

  PlaceSuggestion({required this.name, required this.placeId});
}
// 