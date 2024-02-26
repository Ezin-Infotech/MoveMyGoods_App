import 'package:flutter/material.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/common%20widgets/app_bar.dart';

class AllBookingScreen extends StatelessWidget {
  const AllBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: const PreferredSize(
          preferredSize: Size(375, 85), child: AppBarWidget()),
      body: Column(
        children: [
          Row(
            children: [
              const Text(
                'All Bookings',
                style: TextStyle(
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
