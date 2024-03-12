import 'package:flutter/material.dart';
import 'package:mmg/app/home/view%20model/home_provider.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class GlobalScreen extends StatefulWidget {
  const GlobalScreen({super.key});

  @override
  State<GlobalScreen> createState() => _GlobalScreenState();
}

class _GlobalScreenState extends State<GlobalScreen> {
  @override
  void initState() {
    AppPref.userProfileId = 'b0270f1e-bed8-47cb-b490-662f9f4b51ff';
    AppPref.userToken = 'deb04f14-96f0-476a-acfe-1b588db31dbf';
    context.read<HomeProvider>().getBookingCountFn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, value, _) {
      return Scaffold(
        body: value.pageList[value.curentIndex],
        bottomNavigationBar: SalomonBottomBar(
          margin: const EdgeInsets.all(8),
          // itemPadding: EdgeInsets.all(8),
          selectedItemColor: AppColors.primary,
          duration: const Duration(seconds: 2),
          currentIndex: value.curentIndex,
          onTap: (i) => value.changeCurrentIndex(i),
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Image.asset(
                AppImages.navHome,
                color: value.curentIndex == 0
                    ? AppColors.primary
                    : const Color(0xff59575B),
              ),
              title: const Text("Home"),
              selectedColor: AppColors.primaryBorder,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Image.asset(
                AppImages.navBooking,
                color: value.curentIndex == 1
                    ? AppColors.primary
                    : const Color(0xff59575B),
              ),
              title: const Text("Bookings"),
              selectedColor: AppColors.primaryBorder,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Image.asset(
                AppImages.navSettings,
                color: value.curentIndex == 2
                    ? AppColors.primary
                    : const Color(0xff59575B),
              ),
              title: const Text("Settings"),
              selectedColor: AppColors.primaryBorder,
            ),

            /// Profile
          ],
        ),
      );
    });
  }
}
