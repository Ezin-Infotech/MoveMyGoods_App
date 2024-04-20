import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/bookings/view/widgets/active_vehicle_tracking_map.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/backend/urls.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class CompletedBookingScreen extends StatelessWidget {
  const CompletedBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, obj, _) {
      if (obj.getBookingDetailStatus == GetBookingDetialsStatus.loading) {
        return SizedBox(
          height: Responsive.height * 60,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return CommonScaffold(
            isBackButton: true,
            floatingActionButton: Padding(
              padding: const EdgeInsets.all(8.0),
              child: obj.bookingDetail.data!.status.toString().toUpperCase() ==
                      'PENDING'
                  ? ButtonWidgets(
                      bgColor: Colors.red[900],
                      buttonText: 'CANCEL'.tr,
                      width: context.width,
                      onPressed: () {
                        Get.defaultDialog(
                          title: "CANCEL".tr,
                          titleStyle: const TextStyle(fontSize: 20),
                          content: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                            child: Text("Are you sure, you want to Cancel?".tr),
                          ),
                          confirm: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              context.read<BookingProvider>().cancelBookingFn(
                                  context: context,
                                  id: obj.bookingDetail.data!.id.toString());
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                side: BorderSide.none),
                            child: Text(
                              "Yes".tr,
                              style: context.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.kLight,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          cancel: OutlinedButton(
                              onPressed: () => Get.back(),
                              child: Text(
                                "No".tr,
                                style: context.textTheme.bodyMedium?.copyWith(
                                    color: Colors.green[900],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )),
                        );
                      },
                    )
                  : null,
            ),
            children: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${obj.bookingDetail.data!.status.toString().tr} ${"Bookings".tr}',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: obj.bookingDetail.data!.status
                                      .toString()
                                      .toUpperCase() ==
                                  'PENDING'
                              ? const Color(0xffAE9C00)
                              : obj.bookingDetail.data!.status
                                          .toString()
                                          .toUpperCase() ==
                                      'ACTIVE'
                                  ? const Color(0xff00A51A)
                                  : obj.bookingDetail.data!.status
                                              .toString()
                                              .toUpperCase() ==
                                          'CANCELLED'
                                      ? const Color(0xffA51E00)
                                      : const Color(0xff0076E3),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizeBoxV(8),
                    Icon(
                      obj.bookingDetail.data!.status.toString().toUpperCase() ==
                              'PENDING'
                          ? Icons.access_time_rounded
                          : obj.bookingDetail.data!.status
                                      .toString()
                                      .toUpperCase() ==
                                  'CANCELLED'
                              ? Icons.cancel_rounded
                              : obj.bookingDetail.data!.status
                                          .toString()
                                          .toUpperCase() ==
                                      'ACTIVE'
                                  ? Icons.speed_rounded
                                  : Icons.check_circle_rounded,
                      color: obj.bookingDetail.data!.status
                                  .toString()
                                  .toUpperCase() ==
                              'PENDING'
                          ? const Color(0xffAE9C00)
                          : obj.bookingDetail.data!.status
                                      .toString()
                                      .toUpperCase() ==
                                  'ACTIVE'
                              ? const Color(0xff00A51A)
                              : obj.bookingDetail.data!.status
                                          .toString()
                                          .toUpperCase() ==
                                      'CANCELLED'
                                  ? const Color(0xffA51E00)
                                  : const Color(0xff0076E3),
                    ),
                  ],
                ),
                MediaQuery.removeViewPadding(
                  context: context,
                  removeLeft: true,
                  removeRight: true,
                  child: const Divider(
                    thickness: 1,
                    height: 1,
                    color: Color(0xffC1C1C1),
                  ),
                ),
                const SizeBoxH(15),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      text: "${'Booking Id'.tr} # ",
                      style: context.textTheme.bodyMedium
                          ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
                      children: <TextSpan>[
                        TextSpan(
                          text: obj.bookingDetail.data!.id.toString(),
                          style: context.textTheme.bodyMedium?.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ]),
                ),
                SizeBoxH(Responsive.height * 1),
                ActiveBookingTrackingMapWidget(
                  destination: LatLng(
                      double.parse(obj.bookingDetail.data!.destinationlatitude
                          .toString()),
                      double.parse(obj.bookingDetail.data!.destinationlongitude
                          .toString())),
                  source: LatLng(
                      double.parse(
                          obj.bookingDetail.data!.sourcelatitude.toString()),
                      double.parse(
                          obj.bookingDetail.data!.sourcelongitude.toString())),
                ),
                const SizeBoxH(15),
                Container(
                  width: Responsive.width * 100,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        width: 1,
                        color: const Color(0xffE9E9E9),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(
                              0x40000000), // Color with opacity (hex value: 0x40)
                          offset: Offset(0,
                              1), // Offset from the top-left corner (0px horizontal, 1px vertical)
                          blurRadius: 14.5, // Blur radius (14.5px)
                          spreadRadius: -3, // Spread radius (-3px)
                        )
                      ]),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizeBoxH(Responsive.height * 0.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              TextField(
                                textField: "${'Date'.tr} :",
                              ),
                              TextWidgets(
                                text: dateFunction(
                                    createdAt: obj
                                        .bookingDetail.data!.creationDate!
                                        .toInt()),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              TextField(
                                textField: '${'Time'.tr} :',
                              ),
                              TextWidgets(
                                text: timeFunction(
                                    createdAt: obj
                                        .bookingDetail.data!.creationDate!
                                        .toInt()),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizeBoxH(10),
                      TextField(
                        textField: '${'Vehicle'.tr}: ',
                      ),
                      const SizeBoxH(8),
                      Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    '${Urls.imageBaseUrl}${obj.bookingDetail.data!.vehicleImage!['path']}',
                                  ),
                                  fit: BoxFit.contain)),
                        ),
                      ),
                      const SizeBoxH(10),
                      TextField(
                        textField: '${'Source'.tr}: ',
                      ),
                      const SizeBoxH(8),
                      TextWidgets(
                        text:
                            '${obj.bookingDetail.data!.sStreet.toString()},${obj.bookingDetail.data!.sCity.toString()},${obj.bookingDetail.data!.sState.toString()},${obj.bookingDetail.data!.sCountry.toString()}  ',
                      ),
                      const SizeBoxH(10),
                      TextField(
                        textField: '${"Destination".tr}:  ',
                      ),
                      const SizeBoxH(8),
                      TextWidgets(
                        text:
                            '${obj.bookingDetail.data!.dStreet.toString()},${obj.bookingDetail.data!.dCity.toString()},${obj.bookingDetail.data!.dState.toString()},${obj.bookingDetail.data!.dCountry.toString()}  ',
                      ),
                      const SizeBoxH(10),
                      TextField(
                        textField: '${"Goods Type".tr}: ',
                      ),
                      const SizeBoxH(8),
                      TextWidgets(
                        text: obj.bookingDetail.data!.goodsTypeName!.name
                            .toString(),
                      ),
                      const SizeBoxH(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            textField: '${"Estimated Price".tr}:',
                          ),
                          const SizeBoxH(8),
                          Row(
                            children: [
                              TextWidgets(
                                text:
                                    '₹${obj.bookingDetail.data!.totalAmount.toString()}/-',
                              ),
                              const SizeBoxV(10),
                              obj.showPriceDetails
                                  ? const SizedBox.shrink()
                                  : InkWell(
                                      onTap: () {
                                        context
                                            .read<BookingProvider>()
                                            .changeShowPriceDetails(
                                                isShow: true);
                                      },
                                      child: Text(
                                        'View Price Details'.tr,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: context.textTheme.bodyLarge
                                            ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: const Color(0xff0D9F00),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                obj.showPriceDetails
                    ? PriceDetailsWidget(
                        distance: '${obj.bookingDetail.data!.distance}',
                        netAmount: "${obj.bookingDetail.data!.bookingAmount}",
                        baseFare: "${obj.bookingDetail.data!.baseFare}",
                        pricePerKm: "${obj.bookingDetail.data!.perKm}",
                        labourCost: "${obj.bookingDetail.data!.labourCharges}",
                        cGst: "${obj.bookingDetail.data!.cgst}",
                        gSt: "${obj.bookingDetail.data!.sgst}",
                        totalAmount:
                            obj.bookingDetail.data!.totalAmount.toString())
                    : const SizedBox.shrink(),
                SizeBoxH(Responsive.height * 2),
                ShipperDetailsWidget(
                  cardName: 'Shipper',
                  mobileNumber: '${obj.bookingDetail.data!.consignorNumber}',
                  userName: '${obj.bookingDetail.data!.consignorName}',
                ),
                SizeBoxH(Responsive.height * 2),
                ShipperDetailsWidget(
                  cardName: 'Receiver',
                  mobileNumber: '${obj.bookingDetail.data!.consigneeNumber}',
                  userName: '${obj.bookingDetail.data!.consigneeName}',
                ),
                SizeBoxH(Responsive.height * 2),
                obj.bookingDetail.data!.driver != null ||
                        obj.bookingDetail.data!.status
                                .toString()
                                .toUpperCase() ==
                            'COMPLETED' ||
                        obj.bookingDetail.data!.status
                                .toString()
                                .toUpperCase() ==
                            'ACTIVE'
                    ? Container(
                        width: Responsive.width * 100,
                        decoration: BoxDecoration(
                            color: AppColors.kLight,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffE9E9E9),
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(
                                    0x40000000), // Color with opacity (hex value: 0x40)
                                offset: Offset(0,
                                    1), // Offset from the top-left corner (0px horizontal, 1px vertical)
                                blurRadius: 14.5, // Blur radius (14.5px)
                                spreadRadius: -3, // Spread radius (-3px)
                              )
                            ]),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Text(
                              'Driver Details'.tr,
                              style: context.textTheme.bodyLarge?.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const Divider(
                              color: Color(0xffDDDDDD),
                              height: Checkbox.width,
                              thickness: 1,
                            ),
                            Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        '${Urls.imageBaseUrl}${obj.bookingDetail.data!.driverImage!['path']}',
                                      ),
                                      fit: BoxFit.contain)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      textField: 'Name'.tr,
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    TextField(
                                      textField: 'Mobile No.'.tr,
                                    ),
                                  ],
                                ),
                                const VerticalDivider(
                                  width: 10,
                                  thickness: 1,
                                  indent: 20,
                                  endIndent: 0,
                                  color: Color.fromARGB(255, 83, 13, 13),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizeBoxH(Responsive.height * 1),
                                    TextWidgets(
                                      text:
                                          '${obj.bookingDetail.data!.driver?['firstName']} ${obj.bookingDetail.data!.driver?['lastName']}',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    TextWidgets(
                                      text:
                                          "${obj.bookingDetail.data!.driver?['mobileNumber']}",
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Divider(
                              color: Color(0xffDDDDDD),
                              height: Checkbox.width,
                              thickness: 1,
                            ),
                            SizeBoxH(Responsive.height * 1),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                SizeBoxH(Responsive.height * 2),
                obj.bookingDetail.data!.status.toString().toUpperCase() ==
                        'COMPLETED'
                    ? InkWell(
                        onTap: () {
                          context.read<BookingProvider>().fetchPdfData(
                              id: obj.bookingDetail.data?.id.toString() ?? '');
                        },
                        child: Container(
                          width: Responsive.width * 100,
                          decoration: BoxDecoration(
                              color: AppColors.kLight,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                width: 1,
                                color: const Color(0xffE9E9E9),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(
                                      0x40000000), // Color with opacity (hex value: 0x40)
                                  offset: Offset(0,
                                      1), // Offset from the top-left corner (0px horizontal, 1px vertical)
                                  blurRadius: 14.5, // Blur radius (14.5px)
                                  spreadRadius: -3, // Spread radius (-3px)
                                )
                              ]),
                          padding: const EdgeInsets.all(15),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidgets(
                                text: "Download Invoice",
                              ),
                              Icon(Icons.download_rounded)
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                SizeBoxH(Responsive.height * 10),
              ],
            ));
      }
    });
  }
}

class ShipperDetailsWidget extends StatelessWidget {
  final String cardName;
  final String userName;
  final String mobileNumber;
  const ShipperDetailsWidget({
    super.key,
    required this.cardName,
    required this.mobileNumber,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      decoration: BoxDecoration(
          color: AppColors.kLight,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: 1,
            color: const Color(0xffE9E9E9),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000), // Color with opacity (hex value: 0x40)
              offset: Offset(0,
                  1), // Offset from the top-left corner (0px horizontal, 1px vertical)
              blurRadius: 14.5, // Blur radius (14.5px)
              spreadRadius: -3, // Spread radius (-3px)
            )
          ]),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            '$cardName Details'.tr,
            style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const Divider(
            color: Color(0xffDDDDDD),
            height: Checkbox.width,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    textField: 'Name'.tr,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextField(
                    textField: 'Mobile No.'.tr,
                  ),
                ],
              ),
              const VerticalDivider(
                width: 10,
                thickness: 1,
                indent: 20,
                endIndent: 0,
                color: Color.fromARGB(255, 83, 13, 13),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeBoxH(Responsive.height * 1),
                  TextWidgets(
                    text: userName,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextWidgets(
                    text: mobileNumber,
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            color: Color(0xffDDDDDD),
            height: Checkbox.width,
            thickness: 1,
          ),
          SizeBoxH(Responsive.height * 1),
        ],
      ),
    );
  }
}

class TextField extends StatelessWidget {
  final String? textField;
  const TextField({super.key, this.textField});

  @override
  Widget build(BuildContext context) {
    return Text(
      textField ?? '',
      style: context.textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: const Color(0xff979797)),
    );
  }
}

class TextWidgets extends StatelessWidget {
  final String? text;
  const TextWidgets({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black),
    );
  }
}

dateFunction({required int createdAt}) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createdAt);
  int year = dateTime.year;
  String month = dateTime.month.toString().padLeft(2, '0');
  String day = dateTime.day.toString().padLeft(2, '0');
  int hour = dateTime.hour;

  if (hour > 12) {
    hour -= 12;
  }
  String convertedDate = "$day-$month-$year";
  return convertedDate;
}

timeFunction({required int createdAt}) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(createdAt);

  int hour = dateTime.hour;
  String formattedHour = (hour % 12).toString().padLeft(2, '0');
  int minute = dateTime.minute;
  String formattedMinute = minute.toString().padLeft(2, '0');

  String period = hour < 12 ? 'AM' : 'PM';
  if (hour > 12) {
    hour -= 12;
  }
  String convertedTime = "$formattedHour:$formattedMinute $period";
  return convertedTime;
}

class PriceDetailsWidget extends StatelessWidget {
  final String distance;
  final String netAmount;
  final String baseFare;
  final String pricePerKm;
  final String labourCost;
  final String cGst;
  final String gSt;
  final String totalAmount;
  const PriceDetailsWidget({
    super.key,
    required this.distance,
    required this.netAmount,
    required this.baseFare,
    required this.pricePerKm,
    required this.labourCost,
    required this.cGst,
    required this.gSt,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width * 100,
      decoration: BoxDecoration(
          color: AppColors.kLight,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            width: 1,
            color: const Color(0xffE9E9E9),
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000), // Color with opacity (hex value: 0x40)
              offset: Offset(0,
                  1), // Offset from the top-left corner (0px horizontal, 1px vertical)
              blurRadius: 14.5, // Blur radius (14.5px)
              spreadRadius: -3, // Spread radius (-3px)
            )
          ]),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            'Price Details'.tr,
            style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          const Divider(
            color: Color(0xffDDDDDD),
            height: Checkbox.width,
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    textField: 'Distance'.tr,
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextField(
                    textField: "${'Net Amount'.tr}  ",
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextField(
                    textField: "${'Base Fare'.tr}  ",
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextField(
                    textField: "${'Price Per Km'.tr}  ",
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextField(
                    textField: "${'CGST'.tr}  ",
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextField(textField: "${'GST'.tr}  ")
                ],
              ),
              const VerticalDivider(
                width: 10,
                thickness: 1,
                indent: 20,
                endIndent: 0,
                color: Color.fromARGB(255, 83, 13, 13),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeBoxH(Responsive.height * 1),
                  TextWidgets(
                    text:
                        '${double.parse(distance.toString()).formatTwoDigitsAfterDecimal()} KM',
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextWidgets(
                    text:
                        '₹ ${double.parse(netAmount.toString()).formatTwoDigitsAfterDecimal()}',
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextWidgets(
                    text:
                        '₹ ${double.parse(baseFare.toString()).formatTwoDigitsAfterDecimal()}',
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextWidgets(
                    text:
                        '₹ ${double.parse(pricePerKm.toString()).formatTwoDigitsAfterDecimal()}',
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextWidgets(
                    text:
                        '₹ ${double.parse(cGst.toString()).formatTwoDigitsAfterDecimal()}',
                  ),
                  SizeBoxH(Responsive.height * 1),
                  TextWidgets(
                    text:
                        '₹ ${double.parse(gSt.toString()).formatTwoDigitsAfterDecimal()}',
                  ),
                  SizeBoxH(Responsive.height * 1),
                ],
              ),
            ],
          ),
          const Divider(
            color: Color(0xffDDDDDD),
            height: Checkbox.width,
            thickness: 1,
          ),
          SizeBoxH(Responsive.height * 1),
          Text(
            '${"Total Amount".tr} ₹ ${double.parse(totalAmount.toString()).formatTwoDigitsAfterDecimal()}/-',
            textAlign: TextAlign.center,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: const Color(0xff0D9F00),
            ),
          ),
        ],
      ),
    );
  }
}

extension DoubleExtension on double {
  String formatTwoDigitsAfterDecimal() {
    return toStringAsFixed(2);
  }
}
