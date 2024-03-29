import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/settings/view%20model/theme_notifier.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/common%20widgets/common_scaffold.dart';
import 'package:mmg/app/utils/common%20widgets/toggle_widget.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../home/view model/home_provider.dart';

class BookingListScreen extends StatefulWidget {
  const BookingListScreen({super.key});

  @override
  State<BookingListScreen> createState() => _BookingListScreenState();
}

class _BookingListScreenState extends State<BookingListScreen> {
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
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    return CommonScaffold(
      isBackButton: false,
      // physics: const Sc(),
      children: Consumer<BookingProvider>(builder: (context, value, _) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                value.tempSelectedStatus == 'All'
                    ? Showcase(
                        tooltipBackgroundColor: AppColors.primary,
                        textColor: AppColors.kLight,
                        tooltipPadding: const EdgeInsets.all(16),
                        description: 'Current Booking Status',
                        key: homeProvider.globalKey9,
                        child: Text(
                          'All Bookings'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      )
                    : Showcase(
                        tooltipBackgroundColor: AppColors.primary,
                        textColor: AppColors.kLight,
                        tooltipPadding: const EdgeInsets.all(16),
                        description: 'Current Booking Status',
                        key: homeProvider.globalKey9,
                        child: Row(
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
                              value.tempSelectedStatus.toUpperCase() ==
                                      'PENDING'
                                  ? Icons.access_time_rounded
                                  : value.tempSelectedStatus.toUpperCase() ==
                                          'CANCELLED'
                                      ? Icons.cancel_rounded
                                      : value.tempSelectedStatus
                                                  .toUpperCase() ==
                                              'ACTIVE'
                                          ? Icons.speed_rounded
                                          : Icons.check_circle_rounded,
                              color: value.tempSelectedStatus.toUpperCase() ==
                                      'PENDING'
                                  ? const Color(0xffAE9C00)
                                  : value.tempSelectedStatus.toUpperCase() ==
                                          'ACTIVE'
                                      ? const Color(0xff00A51A)
                                      : value.tempSelectedStatus
                                                  .toUpperCase() ==
                                              'CANCELLED'
                                          ? const Color(0xffA51E00)
                                          : const Color(0xff0076E3),
                            ),
                          ],
                        ),
                      ),
                Showcase(
                  tooltipBackgroundColor: AppColors.primary,
                  textColor: AppColors.kLight,
                  tooltipPadding: const EdgeInsets.all(16),
                  description:
                      'Booking filter option, You can change filter option by selecting booking status.'
                          .tr,
                  key: homeProvider.globalKey8,
                  child: IconButton(
                      icon: const Icon(
                        Icons.filter_list_rounded,
                        size: 18,
                      ),
                      onPressed: () => filterDialog(context)),
                )
              ],
            ),
            const SizeBoxH(8),
            const Divider(
              color: Color(0xffDFDFDF),
              thickness: 1,
            ),
            value.getBookingStatus == GetBookingStatus.loading
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade500,
                    highlightColor: Colors.grey.shade500,
                    direction: ShimmerDirection.ltr,
                    period: const Duration(milliseconds: 1000),
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                height: Responsive.height * 5,
                                decoration: BoxDecoration(
                                  color: AppColors.kLight,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(145, 158, 158, 158),
                                      offset: Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                              ),
                              SizeBoxH(Responsive.height * 2),
                              Container(
                                padding: const EdgeInsets.all(16),
                                height: Responsive.height * 10,
                                decoration: BoxDecoration(
                                  color: AppColors.kLight,
                                  borderRadius: BorderRadius.circular(18),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(145, 158, 158, 158),
                                      offset: Offset(
                                        5.0,
                                        5.0,
                                      ),
                                      blurRadius: 10.0,
                                      spreadRadius: 1.0,
                                    ), //BoxShadow
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizeBoxH(16),
                        itemCount: 10),
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
                                          'Booking Id # ',
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
                                                  SizedBox(
                                                    width:
                                                        Responsive.width * 25,
                                                    child: Text(
                                                      item.status.toString().tr,
                                                      overflow:
                                                          TextOverflow.clip,
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

Future filterDialog(BuildContext context) async {
  return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SimpleDialog(
          contentPadding: const EdgeInsets.all(16),
          insetPadding: const EdgeInsets.all(16),
          children: <Widget>[
            FilterWidget(
              title: 'All'.tr,
            ),
            const SizeBoxH(10),
            FilterWidget(
              title: 'Pending'.tr,
            ),
            const SizeBoxH(10),
            FilterWidget(
              title: 'Active'.tr,
            ),
            const SizeBoxH(10),
            FilterWidget(
              title: 'Completed'.tr,
            ),
            const SizeBoxH(10),
            FilterWidget(
              title: 'Cancelled'.tr,
            ),
          ],
        );
      });
}

class FilterWidget extends StatelessWidget {
  final String title;
  const FilterWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, value, _) {
      return GestureDetector(
        onTap: () => context
            .read<BookingProvider>()
            .filterFunction(status: title, context: context),
        child: SizedBox(
          height: 30,
          child: Row(
            children: [
              MyToggleIconButtonFilter(
                isToggled: title.toLowerCase() ==
                    value.tempSelectedStatus.toLowerCase(),
              ),
              const SizeBoxV(8),
              Expanded(
                child: Text(
                  "$title Bookings",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
