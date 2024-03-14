import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
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
      return obj.getBookingDetailStatus == GetBookingDetialsStatus.loading
          ? SizedBox(
              height: Responsive.height * 60,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : CommonScaffold(
              children: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${obj.bookingDetail.data!.status.toString()} Bookings',
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
                SizeBoxH(Responsive.height * 1),
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
                      text: 'Booking Id # ',
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
                              const TextField(
                                textField: 'Date :',
                              ),
                              TextWidgets(
                                text: dateFunction(
                                    createdAt:
                                        obj.bookingDetail.data!.creationDate!),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              const TextField(
                                textField: 'Time :',
                              ),
                              TextWidgets(
                                text: timeFunction(
                                    createdAt:
                                        obj.bookingDetail.data!.creationDate!),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizeBoxH(10),
                      const TextField(
                        textField: 'Source: ',
                      ),
                      TextWidgets(
                        text:
                            '${obj.bookingDetail.data!.sStreet.toString()},${obj.bookingDetail.data!.sCity.toString()},${obj.bookingDetail.data!.sState.toString()},${obj.bookingDetail.data!.sCountry.toString()}  ',
                      ),
                      const SizeBoxH(10),
                      const TextField(
                        textField: 'Destination:  ',
                      ),
                      TextWidgets(
                        text:
                            '${obj.bookingDetail.data!.dStreet.toString()},${obj.bookingDetail.data!.dCity.toString()},${obj.bookingDetail.data!.dState.toString()},${obj.bookingDetail.data!.dCountry.toString()}  ',
                      ),
                      const SizeBoxH(10),
                      SizedBox(
                        height: Responsive.height * 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                const TextField(
                                  textField: 'Goods Type: ',
                                ),
                                TextWidgets(
                                  text: obj
                                      .bookingDetail.data!.goodsTypeName!.name
                                      .toString(),
                                ),
                              ],
                            ),
                            const SizeBoxV(10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const TextField(
                                  textField: 'Estimated Price:',
                                ),
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
                                              'View Price Details',
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
                            const SizeBoxV(20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizeBoxH(Responsive.height * 2),
                obj.showPriceDetails
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
                              'Price Details',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextField(
                                      textField: 'Distance',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    const TextField(
                                      textField: 'Net Amount  ',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    const TextField(
                                      textField: 'Base Fare ',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    const TextField(
                                      textField: 'Price Per Km  ',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    const TextField(
                                      textField: 'Labour Cost ',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    const TextField(
                                      textField: 'CGST ',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    const TextField(textField: 'GST ')
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
                                          '${obj.bookingDetail.data!.distance} KM',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    TextWidgets(
                                      text:
                                          '₹ ${obj.bookingDetail.data!.bookingAmount}',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    TextWidgets(
                                      text:
                                          '₹ ${obj.bookingDetail.data!.baseFare}',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    TextWidgets(
                                      text:
                                          '₹ ${obj.bookingDetail.data!.perKm}',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    TextWidgets(
                                      text:
                                          '₹ ${obj.bookingDetail.data!.labourCharges}',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    TextWidgets(
                                      text: '₹ ${obj.bookingDetail.data!.cgst}',
                                    ),
                                    SizeBoxH(Responsive.height * 1),
                                    TextWidgets(
                                      text: '₹ ${obj.bookingDetail.data!.sgst}',
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
                              'Total Amount ₹${obj.bookingDetail.data!.totalAmount.toString()}/-',
                              textAlign: TextAlign.center,
                              style: context.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: const Color(0xff0D9F00),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink()
              ],
            ));
    });
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