import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/settings/view%20model/theme_notifier.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:provider/provider.dart';

class SmallBoxontainerWidget extends StatelessWidget {
  final Color? numberColor;
  final String title;
  final String subTitle;
  const SmallBoxontainerWidget(
      {required this.title,
      required this.subTitle,
      this.numberColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(builder: (context, val, _) {
      return InkWell(
        splashColor: Colors.transparent,
        overlayColor: const MaterialStatePropertyAll(Colors.transparent),
        onTap: () {
          context.read<BookingProvider>().filterFromHomeFunction(
              status: title == 'All Bookings'.tr || title == 'Bookings'
                  ? 'All'
                  : title,
              context: context);

          Get.toNamed(AppRoutes.homeBookingListScreen);
        },
        child: Container(
          width: 105,
          height: 75,
          decoration: BoxDecoration(
              color: val.isDarkMode
                  ? AppColors.bgDarkContainer
                  : const Color(0xffE8E8E8),
              boxShadow: [
                BoxShadow(
                  color: val.isDarkMode
                      ? const Color.fromARGB(26, 255, 255, 255)
                      : const Color.fromARGB(145, 158, 158, 158),
                  offset: const Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ), //BoxShadow
                BoxShadow(
                  color:
                      val.isDarkMode ? AppColors.bgDarkContainer : Colors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ), //BoxShadow
              ],
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                title.tr,
                style: const TextStyle(
                    // color: Color(0xffFFFFFF),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              Text(subTitle,
                  style: TextStyle(
                      color: numberColor ?? const Color(0xffFFFFFF),
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'))
            ],
          ),
        ),
      );
    });
  }
}
