import 'dart:convert';
import 'dart:math';

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

  @override
  void initState() {
    super.initState();
    bookingProvider = context.read<BookingProvider?>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getLatitudeAndLongitude();
    });
  }

  void getLatitudeAndLongitude() async {
    LatLng? data = await bookingProvider?.getLocation();
    setState(() {
      currentLocation = data ?? const LatLng(12.2958, 76.6394);
    });
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentLocation,
        zoom: 15.1746,
      ),
    ));
  }

  // void updatePolyline() {
  //   if (fromLocation == null || destinationLocation == null) return;
  //   const String polylineIdVal = 'user_route';
  //   const PolylineId polylineId = PolylineId(polylineIdVal);
  //   final Polyline polyline = Polyline(
  //     startCap: Cap.roundCap,
  //     polylineId: polylineId,
  //     points: [fromLocation!, destinationLocation!],
  //     width: 5,
  //     color: Colors.blue,
  //   );

  //   double southLat = min(
  //     fromLocation!.latitude,
  //     destinationLocation!.latitude,
  //   );
  //   double northLat = max(
  //     fromLocation!.latitude,
  //     destinationLocation!.latitude,
  //   );
  //   double westLng = min(
  //     fromLocation!.longitude,
  //     destinationLocation!.longitude,
  //   );
  //   double eastLng = max(
  //     fromLocation!.longitude,
  //     destinationLocation!.longitude,
  //   );
  //   LatLngBounds bounds = LatLngBounds(
  //     southwest: LatLng(southLat, westLng),
  //     northeast: LatLng(northLat, eastLng),
  //   );
  //   setState(() {
  //     polylines.removeWhere((poly) => poly.polylineId == polylineId);
  //     polylines.add(polyline);
  //   });
  //   Future.delayed(const Duration(milliseconds: 500), () {
  //     mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
  //   });
  // }

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
    } else if (hasFromLocationBeenSelected && fromLocation != null) {
      destinationLocation = location;
      updatePolyline();
    }
  }

  DropdownEditingController<String>? dropdownEditingController;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                        return TextDropdownFormField(
                          onChanged: (dynamic value) async {
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
                            markers.add(Marker(
                              markerId: const MarkerId(""),
                              position: latLng,
                              infoWindow:
                                  const InfoWindow(title: 'Destination'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueRed,
                              ),
                            ));
                            mapController
                                ?.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: latLng,
                                zoom: 15.1746,
                              ),
                            ));
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please select Destination';
                          //   }
                          //   return null;
                          // },
                          dropdownHeight: 200,
                          controller: dropdownEditingController,
                          options:
                              booking.searchResults.map((e) => e.name).toList(),
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
                            markers.add(Marker(
                              markerId: const MarkerId(""),
                              position: latLng,
                              infoWindow:
                                  const InfoWindow(title: 'Destination'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(
                                BitmapDescriptor.hueRed,
                              ),
                            ));
                            mapController
                                ?.animateCamera(CameraUpdate.newCameraPosition(
                              CameraPosition(
                                target: latLng,
                                zoom: 15.1746,
                              ),
                            ));
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'Please select Destination';
                          //   }
                          //   return null;
                          // },
                          dropdownHeight: 200,
                          controller: dropdownEditingController,
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
