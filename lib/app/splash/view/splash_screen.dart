import 'package:flutter/material.dart';
import 'package:mmg/app/splash/view_model/splash_notifier.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/extensions.dart';
import 'package:mmg/app/utils/helpers.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   context.read()
  //   super.initState();
  // }

  @override
  void initState() {
    context.read<SplashProvider>().changeScreen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kLight,
      body: SizedBox(
        height: context.height,
        width: context.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Logo 2 1.png',
              color: AppColors.primary,
            ),
            const SizeBoxH(20),
            const Text("MOVE MY GOODS")
          ],
        ),
      ),
    );
  }
}
