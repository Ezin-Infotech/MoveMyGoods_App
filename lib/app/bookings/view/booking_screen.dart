import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:drop_down_search_field/drop_down_search_field.dart';
import 'package:dropdown_plus_plus/dropdown_plus_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/backend/urls.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/label_and_textfield.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../../utils/common widgets/custom_text.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  BookingProvider? bookingProvider;
  LatLng currentLocation = const LatLng(12.2958, 76.6394);
  Marker? currentLocationMarker;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  GoogleMapController? mapController;
  LatLng? fromLocation;
  LatLng? destinationLocation;
  bool hasFromLocationBeenSelected = false;
  String userCurrentLocation = 'Fetching...';
  DropdownEditingController<String>? dropdownEditingController1;
  DropdownEditingController<String>? dropdownEditingController2;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    bookingProvider = context.read<BookingProvider?>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getLatitudeAndLongitude();
      dropdownEditingController1?.addListener(() {
        setState(() {
          debugPrint('data is  --------------------');
        });
      });
    });
  }

  void getLatitudeAndLongitude() async {
    LatLng? data = await bookingProvider?.getLocation();
    currentLocation = data ?? const LatLng(12.2958, 76.6394);
    await getPlaceName(currentLocation.latitude, currentLocation.longitude);
    setState(() {
      onSelectLocation(currentLocation, true);
    });
  }

  Future<void> getPlaceName(double lat, double lng) async {
    String apiKey = "AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey";

    try {
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = response.data;
        List<dynamic> results = responseData['results'];
        if (results.isNotEmpty) {
          userCurrentLocation = results[0]['formatted_address'];
          debugPrint('data is Place name: $userCurrentLocation');
        }
      } else {
        debugPrint('Failed to get place name: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching place name: $e');
    }
  }

  void updatePolyline() async {
    if (fromLocation == null || destinationLocation == null) return;
    List<LatLng> routePoints = await getRouteFromAPI(
      fromLocation!,
      destinationLocation!,
    );
    const String polylineIdVal = 'user_route';
    const PolylineId polylineId = PolylineId(polylineIdVal);
    final Polyline polyline = Polyline(
      startCap: Cap.roundCap,
      polylineId: polylineId,
      points: routePoints,
      width: 5,
      color: Colors.blue,
    );
    setState(() {
      polylines.removeWhere((poly) => poly.polylineId == polylineId);
      polylines.add(polyline);
    });
    adjustCameraToBounds(routePoints, mapController!);
  }

  Future<List<LatLng>> getRouteFromAPI(LatLng start, LatLng end) async {
    String baseUrl = 'https://maps.googleapis.com/maps/api/directions/json';
    String apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';

    String url = '$baseUrl?origin=${start.latitude},${start.longitude}'
        '&destination=${end.latitude},${end.longitude}&key=$apiKey';

    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      List steps = data['routes'][0]['legs'][0]['steps'];

      List<LatLng> polylinePoints = [];
      for (var step in steps) {
        var point = step['end_location'];
        polylinePoints.add(LatLng(point['lat'], point['lng']));
      }

      return polylinePoints;
    } else {
      throw Exception('Failed to load directions');
    }
  }

  void adjustCameraToBounds(
      List<LatLng> routePoints, GoogleMapController mapController) {
    if (routePoints.isEmpty) return;
    double southLat = routePoints.map((m) => m.latitude).reduce(min);
    double northLat = routePoints.map((m) => m.latitude).reduce(max);
    double westLng = routePoints.map((m) => m.longitude).reduce(min);
    double eastLng = routePoints.map((m) => m.longitude).reduce(max);
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(southLat, westLng),
      northeast: LatLng(northLat, eastLng),
    );
    mapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  void onSelectLocation(LatLng location, bool isFromLocation) {
    if (isFromLocation) {
      fromLocation = location;
      hasFromLocationBeenSelected = true;
      markers.add(Marker(
        markerId: const MarkerId(""),
        position: location,
        infoWindow: const InfoWindow(title: 'Starting Point'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueCyan,
        ),
      ));
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: location,
            zoom: 15.1746,
          ),
        ),
      );
    } else if (hasFromLocationBeenSelected && fromLocation != null) {
      destinationLocation = location;
      markers.add(Marker(
        markerId: const MarkerId(""),
        position: location,
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      ));
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: location,
            zoom: 15.1746,
          ),
        ),
      );
      updatePolyline();
    }
    if (hasFromLocationBeenSelected &&
        fromLocation != null &&
        destinationLocation != null) {
      updatePolyline();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isBackButton: true,
      padding: 0,
      children: Consumer<BookingProvider>(builder: (context, booking, _) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Consumer<BookingProvider>(
                builder: (ctx, obj, _) {
                  return SizedBox(
                    height: Responsive.height * 30,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: true,
                      mapType: MapType.terrain,
                      initialCameraPosition: CameraPosition(
                        target: currentLocation,
                        zoom: 14.4746,
                      ),
                      markers: markers,
                      polylines: polylines,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                      // onTap: (argument) => onSelectLocation(
                      //   argument,
                      //   false,
                      // ),
                      onTap: (argument) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MapScreen(
                              location: currentLocation,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.height * 2),
                    CustomText(
                      text: '${"Source".tr} *',
                    ),
                    const SizeBoxH(8),
                    Consumer<BookingProvider>(
                      builder: (context, booking, _) {
                        // debugPrint(
                        //     "data is ${booking.isHintTextHide == true ? userCurrentLocation = '' : userCurrentLocation = userCurrentLocation}");
                        return TextDropdownFormField(
                          onChanged: (dynamic value) async {
                            debugPrint("data is $value  on changed");
                            PlaceSuggestion place =
                                booking.destinationSearchResults.firstWhere(
                              (element) => element.name == value,
                            );
                            LatLng latLng = await booking.getPlaceDetails(
                              place.placeId,
                              context,
                              true,
                            );
                            onSelectLocation(latLng, true);
                            // markers.add(Marker(
                            //   markerId: const MarkerId(""),
                            //   position: latLng,
                            //   infoWindow:
                            //       const InfoWindow(title: 'Starting Point'),
                            //   icon: BitmapDescriptor.defaultMarkerWithHue(
                            //     BitmapDescriptor.hueRed,
                            //   ),
                            // ));
                            // mapController?.animateCamera(
                            //   CameraUpdate.newCameraPosition(
                            //     CameraPosition(
                            //       target: latLng,
                            //       zoom: 15.1746,
                            //     ),
                            //   ),
                            // );
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please select Destination';
                          //   }
                          //   return null;
                          // },
                          dropdownHeight: 200,
                          controller: dropdownEditingController1,
                          options:
                              booking.searchResults.map((e) => e.name).toList(),
                          decoration: InputDecoration(
                            hintText: userCurrentLocation,
                            hintStyle: context.textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          cursorColor: Colors.green,
                          dropdownItemColor: Colors.red,
                          findFn: (String? value) {
                            userCurrentLocation = "";

                            if (value == null) return Future.value([]);
                            if (value.isEmpty) return Future.value([]);
                            booking.searchLocation(
                              query: value,
                              dest: true,
                            );
                            List<String> results = booking
                                .destinationSearchResults
                                .map((e) => e.name)
                                .toList();
                            return Future.value(results);
                          },
                        );
                      },
                    ),
                    // Consumer<BookingProvider>(
                    //   builder: (context, booking, _) {
                    //     return AdvancedSearch(
                    //       hintText: 'Search your location',
                    //       borderRadius: 4,
                    //       searchItems:
                    // booking.searchResults.map((e) => e.name).toList(),
                    //       maxElementsToDisplay: 7,
                    //       searchResultsBgColor: AppColors.bgColor,
                    //       onItemTap: (index, da) async {
                    // PlaceSuggestion place = booking.searchResults
                    //     .firstWhere((element) => element.name == da);
                    // LatLng latLng = await booking.getPlaceDetails(
                    //     place.placeId, context, true);
                    // onSelectLocation(latLng, true);
                    // markers.add(Marker(
                    //   markerId: const MarkerId(""),
                    //   position: latLng,
                    //   infoWindow: const InfoWindow(title: 'Source'),
                    //   icon: BitmapDescriptor.defaultMarkerWithHue(
                    //     BitmapDescriptor.hueGreen,
                    //   ),
                    // ));
                    // mapController
                    //     ?.animateCamera(CameraUpdate.newCameraPosition(
                    //   CameraPosition(
                    //     target: latLng,
                    //     zoom: 15.1746,
                    //   ),
                    // ));
                    //       },
                    //       onSearchClear: () {
                    //         booking.searchResults.clear();
                    //         bookingProvider?.searchLocation(
                    //           query: '',
                    //           dest: false,
                    //         );
                    //       },
                    //       onEditingProgress: (value, value2) {
                    //         booking.searchLocation(
                    //           query: value,
                    //           dest: false,
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    const SizeBoxH(10),
                    CustomText(
                      text: '${"Destination".tr} *',
                    ),
                    const SizeBoxH(8),
                    Consumer<BookingProvider>(
                      builder: (context, booking, _) {
                        return TextDropdownFormField(
                          onChanged: (dynamic value) async {
                            debugPrint("value is $value");
                            PlaceSuggestion place =
                                booking.destinationSearchResults.firstWhere(
                              (element) => element.name == value,
                            );
                            LatLng latLng = await booking.getPlaceDetails(
                              place.placeId,
                              context,
                              false,
                            );
                            onSelectLocation(latLng, false);
                            debugPrint("latLng is $latLng");
                            // markers.add(Marker(
                            //   markerId: const MarkerId(""),
                            //   position: latLng,
                            //   infoWindow:
                            //       const InfoWindow(title: 'Destination'),
                            //   icon: BitmapDescriptor.defaultMarkerWithHue(
                            //     BitmapDescriptor.hueRed,
                            //   ),
                            // ));
                            // mapController
                            //     ?.animateCamera(CameraUpdate.newCameraPosition(
                            //   CameraPosition(
                            //     target: latLng,
                            //     zoom: 15.1746,
                            //   ),
                            // ));
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please select Destination';
                          //   }
                          //   return null;
                          // },
                          dropdownHeight: 200,
                          controller: dropdownEditingController2,
                          options: booking.destinationSearchResults
                              .map((e) => e.name)
                              .toList(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          cursorColor: Colors.green,
                          dropdownItemColor: Colors.red,
                          findFn: (String? value) {
                            if (value == null) return Future.value([]);
                            if (value.isEmpty) return Future.value([]);
                            booking.searchLocation(
                              query: value,
                              dest: true,
                            );
                            List<String> results = booking
                                .destinationSearchResults
                                .map((e) => e.name)
                                .toList();
                            return Future.value(results);
                          },
                        );
                      },
                    ),
                    const SizeBoxH(8),
                    // Consumer<BookingProvider>(
                    //   builder: (context, booking, _) {
                    //     return AdvancedSearch(
                    //       hintText: 'Search your destination',
                    //       borderRadius: 4,
                    //       searchItems: booking.destinationSearchResults
                    //           .map((e) => e.name)
                    //           .toList(),
                    //       maxElementsToDisplay: 7,
                    //       onItemTap: (index, da) async {
                    // PlaceSuggestion place = booking
                    //     .destinationSearchResults
                    //     .firstWhere((element) => element.name == da);
                    // LatLng latLng = await booking.getPlaceDetails(
                    //     place.placeId, context, false);
                    // onSelectLocation(latLng, false);
                    // markers.add(Marker(
                    //   markerId: const MarkerId(""),
                    //   position: latLng,
                    //   infoWindow:
                    //       const InfoWindow(title: 'Destination'),
                    //   icon: BitmapDescriptor.defaultMarkerWithHue(
                    //     BitmapDescriptor.hueRed,
                    //   ),
                    // ));
                    // mapController
                    //     ?.animateCamera(CameraUpdate.newCameraPosition(
                    //   CameraPosition(
                    //     target: latLng,
                    //     zoom: 15.1746,
                    //   ),
                    // ));
                    //       },
                    //       onSearchClear: () {
                    //         booking.destinationSearchResults.clear();
                    //         bookingProvider?.searchLocation(
                    //           query: '',
                    //           dest: true,
                    //         );
                    //       },
                    //       onEditingProgress: (value, value2) {
                    //         booking.searchLocation(
                    //           query: value,
                    //           dest: true,
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    const SizeBoxH(10),
                    CustomText(
                      text: '${"Goods Type".tr} *',
                    ),
                    const SizeBoxH(8),
                    SizedBox(
                      height: Responsive.height * 7,
                      child: Center(
                        child: DropDownSearchField(
                          hideKeyboard: true,
                          hideOnEmpty: true,
                          textFieldConfiguration: TextFieldConfiguration(
                            controller: booking.goodsTypeController,
                            autofocus: false,
                            style: context.textTheme.bodyLarge!.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.arrow_drop_down_rounded),
                              border: OutlineInputBorder(),
                            ),
                          ),
                          suggestionsCallback: (pattern) async {
                            return booking.goodsTypeData.list!.where((items) {
                              return items.name
                                  .toString()
                                  .toLowerCase()
                                  .contains(
                                    pattern.toLowerCase(),
                                  );
                            }).toList();
                          },
                          itemBuilder: (context, suggestion) {
                            return ListTile(
                                title: Text(suggestion.name.toString()));
                          },
                          onSuggestionSelected: (suggestion) {
                            print('Goods Weight Response $suggestion');
                            context
                                .read<BookingProvider>()
                                .changeGoodsTypeController(
                                    id: suggestion.id.toString(),
                                    value: suggestion.name.toString());
                          },
                          displayAllSuggestionWhenTap: true,
                        ),
                      ),
                    ),
                    BookingTextFieldWidgets(
                      hintText: '300',
                      controller: bookingProvider!.goodsValueController,
                      labeText: '${"Goods Value".tr} *',
                      keyboardType: TextInputType.number,
                      requiredText: 'Please enter Goods Value',
                    ),
                    // BookingTextFieldWidgets(
                    //   hintText: 'Maximum 5 Labours',
                    //   controller: bookingProvider!.numberOfLabourController,
                    //   labeText: 'Number of Labours *',
                    //   keyboardType: TextInputType.number,
                    //   maxLength: 1,
                    //   requiredText: 'Please enter Number of Labours',
                    // ),
                    // Text(
                    //   'Number of labours should not exceed more than 5',
                    //   style: context.textTheme.bodyMedium!
                    //       .copyWith(color: Colors.red),
                    // ),
                    const SizeBoxH(10),
                    CustomText(
                      text: '${"Goods Weight".tr} *',
                    ),
                    const SizeBoxH(8),
                    // const DropdownInsideTextFormField(),
                    // const SizeBoxH(8),
                    booking.showGoodsWeight
                        ? booking.getGoodsWeightStatus ==
                                GetGoodsWeightStatus.loading
                            ? const SizedBox.shrink()
                            : Container(
                                decoration: BoxDecoration(
                                    color: AppColors.bgColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.grey
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 0, // Spread radius
                                        blurRadius: 8, // Blur radius
                                        // offset: const Offset(0, 3),
                                      ),
                                      BoxShadow(
                                        color: AppColors.grey
                                            .withOpacity(0.8), // Shadow color
                                        spreadRadius: 0, // Spread radius
                                        blurRadius: 2, // Blur radius
                                        // offset: const Offset(0, 3),
                                      ),
                                      BoxShadow(
                                        color: AppColors.grey
                                            .withOpacity(0.7), // Shadow color
                                        spreadRadius: 0, // Spread radius
                                        blurRadius: 1, // Blur radius
                                        // offset: const Offset(0, 3),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        width: 1,
                                        color: const Color(0xffDBDBDB))),
                                child: Column(
                                  children: [
                                    ListView.builder(
                                      itemCount: booking.goodsWeightData
                                          .fareWeightList!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Row(
                                          children: [
                                            MyToggleIconButton(
                                              isToggled: index ==
                                                  booking.goodsWeightIndex,
                                              onPressed: () => context
                                                  .read<BookingProvider>()
                                                  .changeGoodsWeight(
                                                      index: index,
                                                      id: booking
                                                          .goodsWeightData
                                                          .fareWeightList![
                                                              index]
                                                          .weightId
                                                          .toString()),
                                            ),
                                            Text(
                                              booking.goodsWeightData
                                                  .fareWeightList![index].weight
                                                  .toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(),
                                            ),
                                            const SizeBoxV(6),
                                            Text(
                                              '₹${booking.goodsWeightData.fareWeightList![index].totalAmount}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                        : const SizedBox.shrink(),
                    booking.showVehicleImage
                        ? SizeBoxH(Responsive.height * 2)
                        : const SizedBox.shrink(),
                    booking.showVehicleImage
                        ? Image.network(
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(child: Text('error')),
                            // loadingBuilder: (context, child, loadingProgress) =>
                            //     CircularProgressIndicator(
                            //   value: double.parse(loadingProgress!
                            //       .cumulativeBytesLoaded
                            //       .toString()),
                            // ),
                            '${Urls.imageBaseUrl}${booking.goodsVehicleDetailsModel.data![0].path}',
                            width: Responsive.width * 216,
                            height: Responsive.height * 16,
                          )
                        : const SizedBox.shrink(),
                    booking.showVehicleImage
                        ? SizeBoxH(Responsive.height * 1)
                        : const SizedBox.shrink(),
                    booking.showFarePrice
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${"Total Amount".tr}: ₹ ${booking.bookingFarePriceDetailsModel.data!.totalAmount} /-',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: const Color(0xff0D9F00)),
                              ),
                              IconButton(
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 28,
                                  ),
                                  onPressed: () => priceDialog(
                                        context: context,
                                        baseFare: booking
                                            .bookingFarePriceDetailsModel
                                            .data!
                                            .baseFare
                                            .toString(),
                                        cgst: booking
                                            .bookingFarePriceDetailsModel
                                            .data!
                                            .cgst
                                            .toString(),
                                        costPerKm: booking
                                            .bookingFarePriceDetailsModel
                                            .data!
                                            .perKm
                                            .toString(),
                                        distance: booking
                                            .bookingFarePriceDetailsModel
                                            .data!
                                            .distance
                                            .toString(),
                                        labourCost: booking
                                            .bookingFarePriceDetailsModel
                                            .data!
                                            .labourCharges
                                            .toString(),
                                        sgst: booking
                                            .bookingFarePriceDetailsModel
                                            .data!
                                            .sgst
                                            .toString(),
                                      )),
                            ],
                          )
                        : const SizedBox.shrink(),
                    booking.showFarePrice
                        ? SizeBoxH(Responsive.height * 0.7)
                        : const SizedBox.shrink(),
                    booking.showFarePrice
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "*${'The price is an indicative and actual price may vary'.tr}",
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        color: const Color(0xffF90000)),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    SizeBoxH(Responsive.height * 3),
                    booking.showRecieverDetails
                        ? const SizedBox.shrink()
                        : booking.showFarePrice
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonWidgets(
                                    buttonText: 'Continue'.tr,
                                    onPressed: () {
                                      context
                                          .read<BookingProvider>()
                                          .changeShowRecieverDetails(
                                              isShow: true);
                                      // context.push(const LoginScreen());
                                    },
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                    SizeBoxH(Responsive.height * 4),
                    Consumer<BookingProvider>(builder: (context, value, _) {
                      return value.showRecieverDetails
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Billing Details'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: const Color(0xff222222)),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        MyToggleIconButton(
                                          isToggled: value.billingId == 1,
                                          onPressed: () {
                                            context
                                                .read<BookingProvider>()
                                                .setBillingId(value: 1);
                                          },
                                        ),
                                        Text(
                                          'PAID'.tr,
                                          style: context.textTheme.bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xffA8A4B0)),
                                        )
                                      ],
                                    ),
                                    const SizeBoxV(65),
                                    Row(
                                      children: [
                                        MyToggleIconButton(
                                          isToggled: value.billingId == 2,
                                          onPressed: () {
                                            context
                                                .read<BookingProvider>()
                                                .setBillingId(value: 2);
                                          },
                                        ),
                                        Text(
                                          'FOD'.tr,
                                          style: context.textTheme.bodySmall!
                                              .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xffA8A4B0)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),

                                const SizeBoxH(15),
                                Text(
                                  '*Receiver Details'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: const Color(0xff222222)),
                                ),
                                BookingTextFieldWidgets(
                                  hintText: 'Name'.tr,
                                  controller:
                                      bookingProvider!.receiverNameController,
                                  labeText: 'Name'.tr,
                                  requiredText: 'Enter Your name '.tr,
                                ),
                                // BookingTextFieldWidgets(
                                //   hintText: 'Email',
                                //   controller:
                                //       bookingProvider!.receiverEmailController,
                                //   labeText: 'Email Address',
                                //   keyboardType: TextInputType.emailAddress,
                                //   requiredText: 'Enter Your Email',
                                // ),
                                BookingTextFieldWidgets(
                                  hintText: 'Enter Your Mobile No'.tr,
                                  controller: bookingProvider!
                                      .receiverMobileNoController,
                                  labeText: 'Mobile No.'.tr,
                                  keyboardType: TextInputType.phone,
                                  requiredText: 'enter mobile number'.tr,
                                ),
                                // const SizeBoxH(10),
                                // const CustomText(
                                //   text: 'Reference Numbers',
                                // ),
                                // const SizeBoxH(8),
                                // const DropdownInsideTextFormField(),

                                // const SizeBoxH(10),
                                // const CustomText(
                                //   text: 'Location',
                                // ),
                                // const SizeBoxH(8),
                                // const DropdownInsideTextFormField(),
                                // BookingTextFieldWidgets(
                                //   hintText: '(eg.DUMPA1234)',
                                //   controller:
                                //       bookingProvider!.receiverPanNoController,
                                //   labeText: 'PAN No.',
                                //   requiredText: 'Enter Your PAN No ',
                                // ),
                                BookingTextFieldWidgets(
                                  hintText: '(eg.GHXXXXXXXX000)',
                                  controller:
                                      bookingProvider!.receiverGstNoController,
                                  labeText: 'GST No.'.tr,
                                  requiredText: 'Enter GST Number',
                                ),
                                SizeBoxH(Responsive.height * 2),
                                Text(
                                  '*Shipper Details'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: const Color(0xff222222)),
                                ),
                                // SizeBoxH(Responsive.height * 1),
                                BookingTextFieldWidgets(
                                  hintText: 'Name'.tr,
                                  controller:
                                      bookingProvider!.shipperNameController,
                                  labeText: 'Name'.tr,
                                  requiredText: 'Enter Your name'.tr,
                                ),
                                // BookingTextFieldWidgets(
                                //   hintText: 'Email',
                                //   controller:
                                //       bookingProvider!.shipperemailController,
                                //   labeText: 'Email Address',
                                //   keyboardType: TextInputType.emailAddress,
                                //   requiredText: 'Enter Your Email ',
                                // ),
                                BookingTextFieldWidgets(
                                  hintText: 'Number'.tr,
                                  controller: bookingProvider!
                                      .shipperMobileNoController,
                                  labeText: 'Mobile No.'.tr,
                                  keyboardType: TextInputType.phone,
                                  requiredText: 'Please enter Mobile Number'.tr,
                                ),

                                // BookingTextFieldWidgets(
                                //   hintText: '(eg.DUMPA1234)',
                                //   controller:
                                //       bookingProvider!.shipperpanNOController,
                                //   labeText: 'PAN No.',
                                // ),
                                BookingTextFieldWidgets(
                                  hintText: '(eg.GHXXXXXXXX000)',
                                  controller:
                                      bookingProvider!.shipperGstNoController,
                                  labeText: 'GST No.'.tr,
                                  requiredText: 'Enter GST Number',
                                ),
                                SizeBoxH(Responsive.height * 2),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonWidgets(
                                      buttonText: 'Book Now'.tr,
                                      onPressed: () {
                                        print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                                        if (_formKey.currentState!.validate()) {
                                          context
                                              .read<BookingProvider>()
                                              .confirmBookingFn(
                                                  context: context);
                                        }
                                        // Get.toNamed(AppRoutes
                                        //     .bookingSuccessFullyCompletedScreen);
                                        // context.push(const LoginScreen());
                                      },
                                    ),
                                  ],
                                ),
                                const SizeBoxH(10),
                              ],
                            )
                          : const SizedBox.shrink();
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
// bookingFarePriceDetailsModel = goodsResponse;

Future priceDialog(
    {required BuildContext context,
    required String distance,
    required String baseFare,
    required String costPerKm,
    required String labourCost,
    required String cgst,
    required String sgst}) async {
  return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(38),
          insetPadding: const EdgeInsets.all(16),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"Distance".tr}  :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  distance,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizeBoxH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"Base Fare".tr}  :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  baseFare,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizeBoxH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"Price Per Km".tr}  :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  costPerKm,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizeBoxH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"Labour Cost".tr}  :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  labourCost,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizeBoxH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"CGST".tr}  :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  cgst,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizeBoxH(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${"SGST".tr}  :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Text(
                  sgst,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ],
        );
      });
}

// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.location});
  final LatLng location;
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng? fromLocation;
  LatLng? toLocation;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, {'from': fromLocation, 'to': toLocation});
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (controller) {
                _controller = controller;
              },
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                zoom: 15,
              ),
              onTap: (LatLng latLng) {
                setState(() {
                  if (fromLocation == null) {
                    fromLocation = latLng;
                  } else {
                    toLocation ??= latLng;
                  }
                });
              },
              markers: <Marker>{
                if (fromLocation != null)
                  Marker(
                    markerId: const MarkerId('fromLocation'),
                    position: fromLocation!,
                    infoWindow: const InfoWindow(title: 'From Location'),
                  ),
                if (toLocation != null)
                  Marker(
                    markerId: const MarkerId('toLocation'),
                    position: toLocation!,
                    infoWindow: const InfoWindow(title: 'To Location'),
                  ),
              },
            ),
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search for a place...',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          searchPlaces(_searchController.text);
                        },
                      ),
                      prefixIcon: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(
                            context,
                            {
                              'from': fromLocation,
                              'to': toLocation,
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchPlaces(String query) async {
    String apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';
    String url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$apiKey';

    try {
      Response response = await Dio().get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.data);
        List<dynamic> results = data['results'];

        setState(() {
          fromLocation = null;
          toLocation = null;
          for (var result in results) {
            double lat = result['geometry']['location']['lat'];
            double lng = result['geometry']['location']['lng'];
            String name = result['name'];
            Marker marker = Marker(
              markerId: MarkerId(name),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: name),
            );
            _controller?.moveCamera(
              CameraUpdate.newLatLng(
                LatLng(lat, lng),
              ),
            );
          }
        });
      } else {
        print('Failed to fetch search results: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching search results: $e');
    }
  }
}
