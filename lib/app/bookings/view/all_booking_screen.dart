import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';

class AllBookingScreen extends StatelessWidget {
  const AllBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        AppImages.whiteLogo,
                        width: 44,
                        height: 44,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Move My Goods'.tr,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          Text(
                            'Digital Logistic Platform'.tr,
                            style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            const CircleAvatar(
              maxRadius: 20,
              backgroundImage: AssetImage('assets/avathar1.png'),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Text(
                'All Bookings'.tr,
                style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xff222222)),
              ),
              ImageIcon(AssetImage(AppImages.filterLogo))
            ],
          )
        ],
      ),
    );
  }
}
