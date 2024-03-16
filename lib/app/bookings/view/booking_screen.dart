import 'dart:math';

import 'package:advanced_search/advanced_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/bookings/view/widgets/drop_down_widgets.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/backend/urls.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/label_and_textfield.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
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
    // LatLng? data = await bookingProvider?.getLocation();
    setState(() {
      // currentLocation = data ?? const LatLng(12.2958, 76.6394);
    });
    mapController?.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: currentLocation,
        zoom: 15.1746,
      ),
    ));
  }

  void updatePolyline() {
    if (fromLocation == null || destinationLocation == null) return;

    const String polylineIdVal = 'user_route';
    const PolylineId polylineId = PolylineId(polylineIdVal);
    final Polyline polyline = Polyline(
      polylineId: polylineId,
      points: [fromLocation!, destinationLocation!],
      width: 5,
      color: Colors.blue,
    );

    double southLat = min(
      fromLocation!.latitude,
      destinationLocation!.latitude,
    );
    double northLat = max(
      fromLocation!.latitude,
      destinationLocation!.latitude,
    );
    double westLng = min(
      fromLocation!.longitude,
      destinationLocation!.longitude,
    );
    double eastLng = max(
      fromLocation!.longitude,
      destinationLocation!.longitude,
    );
    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(southLat, westLng),
      northeast: LatLng(northLat, eastLng),
    );
    setState(() {
      polylines.removeWhere((poly) => poly.polylineId == polylineId);
      polylines.add(polyline);
    });
    Future.delayed(const Duration(milliseconds: 500), () {
      mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));
    });
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

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      padding: 0,
      children: Consumer<BookingProvider>(builder: (context, booking, _) {
        return Column(
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
                  const CustomText(
                    text: 'Source *',
                  ),
                  const SizeBoxH(8),
                  Consumer<BookingProvider>(
                    builder: (context, booking, _) {
                      return AdvancedSearch(
                        hintText: 'Search your location',
                        borderRadius: 4,
                        searchItems:
                            booking.searchResults.map((e) => e.name).toList(),
                        maxElementsToDisplay: 7,
                        searchResultsBgColor: AppColors.bgColor,
                        onItemTap: (index, da) async {
                          PlaceSuggestion place = booking.searchResults
                              .firstWhere((element) => element.name == da);
                          LatLng latLng = await booking.getPlaceDetails(
                            place.placeId,
                          );
                          onSelectLocation(latLng, true);
                          markers.add(Marker(
                            markerId: const MarkerId(""),
                            position: latLng,
                            infoWindow: const InfoWindow(title: 'Source'),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueGreen,
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
                        onSearchClear: () {
                          booking.searchResults.clear();
                          bookingProvider?.searchLocation(
                            query: '',
                            dest: false,
                          );
                        },
                        onEditingProgress: (value, value2) {
                          booking.searchLocation(
                            query: value,
                            dest: false,
                          );
                        },
                      );
                    },
                  ),
                  const SizeBoxH(10),
                  const CustomText(
                    text: 'Destination *',
                  ),
                  const SizeBoxH(8),
                  Consumer<BookingProvider>(
                    builder: (context, booking, _) {
                      return AdvancedSearch(
                        hintText: 'Search your destination',
                        borderRadius: 4,
                        searchItems: booking.destinationSearchResults
                            .map((e) => e.name)
                            .toList(),
                        maxElementsToDisplay: 7,
                        onItemTap: (index, da) async {
                          PlaceSuggestion place = booking
                              .destinationSearchResults
                              .firstWhere((element) => element.name == da);
                          LatLng latLng = await booking.getPlaceDetails(
                            place.placeId,
                          );
                          onSelectLocation(latLng, false);
                          markers.add(Marker(
                            markerId: const MarkerId(""),
                            position: latLng,
                            infoWindow: const InfoWindow(title: 'Destination'),
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
                        onSearchClear: () {
                          booking.destinationSearchResults.clear();
                          bookingProvider?.searchLocation(
                            query: '',
                            dest: true,
                          );
                        },
                        onEditingProgress: (value, value2) {
                          booking.searchLocation(
                            query: value,
                            dest: true,
                          );
                        },
                      );
                    },
                  ),
                  const SizeBoxH(10),
                  const CustomText(
                    text: 'Goods Type *',
                  ),
                  const SizeBoxH(8),
                  // SizedBox(
                  //   height: Responsive.height * 6,
                  //   child: DropDownSearchField(
                  //     hideKeyboard: true,
                  //     hideOnEmpty: true,
                  //     textFieldConfiguration: TextFieldConfiguration(
                  //       controller: booking.goodsTypeController,
                  //       autofocus: false,
                  //       style: context.textTheme.bodyLarge!.copyWith(
                  //           fontSize: 16, fontWeight: FontWeight.w400),
                  //       decoration: const InputDecoration(
                  //         border: OutlineInputBorder(),
                  //       ),
                  //     ),
                  //     suggestionsCallback: (pattern) async {
                  //       return booking.goodsTypeData.list!.where((items) {
                  //         return items.name.toString().toLowerCase().contains(
                  //               pattern.toLowerCase(),
                  //             );
                  //       }).toList();
                  //     },
                  //     itemBuilder: (context, suggestion) {
                  //       return ListTile(
                  //           title: Text(suggestion.name.toString()));
                  //     },
                  //     onSuggestionSelected: (suggestion) {
                  //       print("$suggestion tapped");
                  //       context
                  //           .read<BookingProvider>()
                  //           .changeGoodsTypeController(
                  //               id: suggestion.id.toString(),
                  //               value: suggestion.name.toString());
                  //     },
                  //     displayAllSuggestionWhenTap: true,
                  //   ),
                  // ),
                  BookingTextFieldWidgets(
                    hintText: '300',
                    controller: bookingProvider!.goodsValueController,
                    labeText: 'Goods Value *',
                    keyboardType: TextInputType.number,
                  ),
                  BookingTextFieldWidgets(
                    hintText: 'Maximum 5 Labours',
                    controller: bookingProvider!.numberOfLabourController,
                    labeText: 'Number of Labours *',
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                  ),
                  // Text(
                  //   'Number of labours should not exceed more than 5',
                  //   style: context.textTheme.bodyMedium!
                  //       .copyWith(color: Colors.red),
                  // ),
                  const SizeBoxH(10),
                  const CustomText(
                    text: 'Goods Weight *',
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
                                    itemCount: booking
                                        .goodsWeightData.fareWeightList!.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          MyToggleIconButton(
                                            isToggled: booking
                                                    .goodsWeightData
                                                    .fareWeightList![index]
                                                    .weightId
                                                    .toString() ==
                                                booking.goodsWeightId,
                                            onPressed: () => context
                                                .read<BookingProvider>()
                                                .changeGoodsWeight(
                                                    id: booking
                                                        .goodsWeightData
                                                        .fareWeightList![index]
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
                              'Total Amount: ₹ ${booking.bookingFarePriceDetailsModel.data!.totalAmount} /-',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: const Color(0xff0D9F00)),
                            ),
                            const Icon(
                              Icons.arrow_drop_down,
                              size: 28,
                            )
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
                              '*The price is an indicative and actual price may vary ',
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
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonWidgets(
                              buttonText: 'Continue',
                              onPressed: () {
                                context
                                    .read<BookingProvider>()
                                    .changeShowRecieverDetails(isShow: true);
                                // context.push(const LoginScreen());
                              },
                            ),
                          ],
                        ),
                  SizeBoxH(Responsive.height * 4),
                  Consumer<BookingProvider>(builder: (context, value, _) {
                    return value.showRecieverDetails
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '*Receiver Details',
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall!
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: const Color(0xff222222)),
                              ),
                              BookingTextFieldWidgets(
                                hintText: 'Name',
                                controller:
                                    bookingProvider!.receiverNameController,
                                labeText: 'Name',
                              ),
                              BookingTextFieldWidgets(
                                hintText: 'Email',
                                controller:
                                    bookingProvider!.receiverEmailController,
                                labeText: 'Email Address',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              BookingTextFieldWidgets(
                                hintText: 'Number',
                                controller:
                                    bookingProvider!.receiverMobileNoController,
                                labeText: 'Mobile No.',
                                keyboardType: TextInputType.phone,
                              ),
                              const SizeBoxH(10),
                              const CustomText(
                                text: 'Reference Numbers',
                              ),
                              const SizeBoxH(8),
                              const DropdownInsideTextFormField(),

                              const SizeBoxH(10),
                              const CustomText(
                                text: 'Location',
                              ),
                              const SizeBoxH(8),
                              const DropdownInsideTextFormField(),
                              BookingTextFieldWidgets(
                                hintText: '(eg.DUMPA1234)',
                                controller:
                                    bookingProvider!.receiverPanNoController,
                                labeText: 'PAN No.',
                              ),
                              BookingTextFieldWidgets(
                                hintText: '(eg.GHXXXXXXXX000)',
                                controller:
                                    bookingProvider!.receiverGstNoController,
                                labeText: 'GST No.',
                              ),
                              SizeBoxH(Responsive.height * 2),
                              Text(
                                '*Shipper Details',
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
                                hintText: 'Name',
                                controller:
                                    bookingProvider!.shipperNameController,
                                labeText: 'Name',
                              ),
                              BookingTextFieldWidgets(
                                hintText: 'Email',
                                controller:
                                    bookingProvider!.shipperemailController,
                                labeText: 'Email Address',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              BookingTextFieldWidgets(
                                hintText: 'Number',
                                controller:
                                    bookingProvider!.shipperMobileNoController,
                                labeText: 'Mobile No.',
                                keyboardType: TextInputType.phone,
                              ),

                              BookingTextFieldWidgets(
                                hintText: '(eg.DUMPA1234)',
                                controller:
                                    bookingProvider!.shipperpanNOController,
                                labeText: 'PAN No.',
                              ),
                              BookingTextFieldWidgets(
                                hintText: '(eg.GHXXXXXXXX000)',
                                controller:
                                    bookingProvider!.shipperGstNoController,
                                labeText: 'GST No.',
                              ),
                              SizeBoxH(Responsive.height * 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonWidgets(
                                    buttonText: 'Book Now',
                                    onPressed: () {
                                      Get.toNamed(AppRoutes
                                          .bookingSuccessFullyCompletedScreen);
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
        );
      }),
    );
  }
}

List<String> items = ['Item 1', 'Item 2', 'Item 3'];
