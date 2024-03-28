import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({
    super.key,
  });

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 100.wp,
        height: 100.hp,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25.hp,
                width: 50.wp,
                // color: Colors.amber,
                child: Lottie.asset(
                  'assets/no_internet_screen.json',
                  width: 30.wp, // Adjust as needed
                  height: 30.hp, // Adjust as needed
                  fit: BoxFit.cover,
                  repeat: true,
                  animate: true,
                ),
              ),
              const SizeBoxH(30),
              // const SizeBoxH(16),
              Text(
                "No internet connection!".tr,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: const Color.fromARGB(255, 102, 102, 102),
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                ),
              ),
              const SizeBoxH(10),
              Text(
                "Please check your internet connection and try again".tr,
                style: context.textTheme.titleMedium!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizeBoxH(16),
              ButtonWidgets(
                  onPressed: () {
                    // LoadingOverlay.of(context).hide();
                    Get.back();
                  },
                  buttonText: "Try Again".tr),
            ],
          ),
        ),
      ),
    );
  }
}
