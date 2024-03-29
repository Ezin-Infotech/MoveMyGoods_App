import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/bookings/view/booking_list.dart';
import 'package:mmg/app/settings/view%20model/theme_notifier.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:provider/provider.dart';

class HomeBookingListScreen extends StatefulWidget {
  const HomeBookingListScreen({super.key});

  @override
  State<HomeBookingListScreen> createState() => _HomeBookingListScreenState();
}

class _HomeBookingListScreenState extends State<HomeBookingListScreen> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    final cntroller = Provider.of<BookingProvider>(context, listen: false);
    if (AppPref.userToken != '') {
      cntroller.tempSelectedStatus == 'All'
          ? cntroller.getAllBookingByStatusFn()
          : cntroller.getBookingByStatusFn();
    }

    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      isBackButton: true,
      // physics: const Sc(),
      children: Consumer<BookingProvider>(builder: (context, value, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                value.tempSelectedStatus == 'All'
                    ? Text(
                        'All Bookings'.tr,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    : Row(
                        children: [
                          Text(
                            '${value.tempSelectedStatus} Bookings'.tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: value.tempSelectedStatus
                                                .toUpperCase() ==
                                            'PENDING'
                                        ? const Color(0xffAE9C00)
                                        : value.tempSelectedStatus
                                                    .toUpperCase() ==
                                                'ACTIVE'
                                            ? const Color(0xff00A51A)
                                            : value.tempSelectedStatus
                                                        .toUpperCase() ==
                                                    'CANCELLED'
                                                ? const Color(0xffA51E00)
                                                : const Color(0xff0076E3),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                          ),
                          const SizeBoxV(8),
                          Icon(
                            value.tempSelectedStatus.toUpperCase() == 'PENDING'
                                ? Icons.access_time_rounded
                                : value.tempSelectedStatus.toUpperCase() ==
                                        'CANCELLED'
                                    ? Icons.cancel_rounded
                                    : value.tempSelectedStatus.toUpperCase() ==
                                            'ACTIVE'
                                        ? Icons.speed_rounded
                                        : Icons.check_circle_rounded,
                            color: value.tempSelectedStatus.toUpperCase() ==
                                    'PENDING'
                                ? const Color(0xffAE9C00)
                                : value.tempSelectedStatus.toUpperCase() ==
                                        'ACTIVE'
                                    ? const Color(0xff00A51A)
                                    : value.tempSelectedStatus.toUpperCase() ==
                                            'CANCELLED'
                                        ? const Color(0xffA51E00)
                                        : const Color(0xff0076E3),
                          ),
                        ],
                      ),
                IconButton(
                    icon: const Icon(
                      Icons.filter_list_rounded,
                      size: 18,
                    ),
                    onPressed: () => filterDialog(context))
              ],
            ),
            const SizeBoxH(8),
            const Divider(
              color: Color(0xffDFDFDF),
              thickness: 1,
            ),
            value.getBookingStatus == GetBookingStatus.loading
                ? const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : value.getBookingStatus == GetBookingStatus.initial ||
                        value.bookingata.list == null ||
                        value.bookingata.list!.isEmpty
                    ? SizedBox(
                        height: 400,
                        width: context.width,
                        child: Center(
                          child: Text('No Bookings'.tr),
                        ),
                      )
                    : Consumer<ThemeNotifier>(builder: (context, val, _) {
                        return ListView.separated(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = value.bookingata.list![index];
                              DateTime dateTime =
                                  DateTime.fromMillisecondsSinceEpoch(
                                      item.pickUpDateTime!);
                              int year = dateTime.year;
                              String month =
                                  dateTime.month.toString().padLeft(2, '0');
                              String day =
                                  dateTime.day.toString().padLeft(2, '0');
                              int hour = dateTime.hour;
                              String formattedHour =
                                  (hour % 12).toString().padLeft(2, '0');
                              int minute = dateTime.minute;
                              String formattedMinute =
                                  minute.toString().padLeft(2, '0');

                              String period = hour < 12 ? 'AM' : 'PM';
                              if (hour > 12) {
                                hour -= 12;
                              }
                              String convertedDate = "$day-$month-$year";
                              String convertedTime =
                                  "$formattedHour:$formattedMinute $period";
                              return GestureDetector(
                                onTap: () {
                                  context
                                      .read<BookingProvider>()
                                      .changeShowPriceDetails(isShow: false);
                                  context
                                      .read<BookingProvider>()
                                      .getBookingDetailsByIdFn(
                                          id: item.id.toString());
                                  Get.toNamed(AppRoutes.completedBookingScreen);
                                },
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "${'Booking Id'.tr} # ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          item.id.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                    const SizeBoxH(8),
                                    Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          color: val.isDarkMode
                                              ? AppColors.bgDarkContainer
                                              : AppColors.kLight,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          boxShadow: [
                                            BoxShadow(
                                              color: val.isDarkMode
                                                  ? const Color.fromARGB(
                                                      26, 255, 255, 255)
                                                  : const Color.fromARGB(
                                                      145, 158, 158, 158),
                                              offset: const Offset(
                                                5.0,
                                                5.0,
                                              ),
                                              blurRadius: 10.0,
                                              spreadRadius: 1.0,
                                            ), //BoxShadow
                                            BoxShadow(
                                              color: val.isDarkMode
                                                  ? AppColors.bgDarkContainer
                                                  : Colors.white,
                                              offset: const Offset(0.0, 0.0),
                                              blurRadius: 0.0,
                                              spreadRadius: 0.0,
                                            ), //BoxShadow
                                          ],
                                          border: Border.all(
                                              color: AppColors.black
                                                  .withOpacity(0.1))),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Date'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0xff979797),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              Text(
                                                convertedDate,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          const SizeBoxV(20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Time'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0xff979797),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              Text(
                                                convertedTime,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                              )
                                            ],
                                          ),
                                          const SizeBoxV(20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Status'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color: const Color(
                                                            0xff979797),
                                                        fontWeight:
                                                            FontWeight.w400),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    item.status == 'PENDING'
                                                        ? Icons
                                                            .access_time_rounded
                                                        : item.status ==
                                                                'CANCELLED'
                                                            ? Icons
                                                                .cancel_rounded
                                                            : item.status ==
                                                                    'ACTIVE'
                                                                ? Icons
                                                                    .speed_rounded
                                                                : Icons
                                                                    .check_circle_rounded,
                                                    color: item.status ==
                                                            'PENDING'
                                                        ? const Color(
                                                            0xffAE9C00)
                                                        : item.status ==
                                                                'ACTIVE'
                                                            ? const Color(
                                                                0xff00A51A)
                                                            : item.status ==
                                                                    'CANCELLED'
                                                                ? const Color(
                                                                    0xffA51E00)
                                                                : const Color(
                                                                    0xff0076E3),
                                                  ),
                                                  const SizeBoxV(8),
                                                  Text(
                                                    item.status.toString().tr,
                                                    style: context
                                                        .textTheme.bodyLarge!
                                                        .copyWith(
                                                            color: item.status ==
                                                                    'PENDING'
                                                                ? const Color(
                                                                    0xffAE9C00)
                                                                : item.status ==
                                                                        'ACTIVE'
                                                                    ? const Color(
                                                                        0xff00A51A)
                                                                    : item.status ==
                                                                            'CANCELLED'
                                                                        ? const Color(
                                                                            0xffA51E00)
                                                                        : const Color(
                                                                            0xff0076E3),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizeBoxH(16),
                            itemCount: value.bookingata.list!.length);
                      })
          ],
        );
      }),
    );
  }
}
