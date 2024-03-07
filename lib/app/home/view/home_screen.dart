import 'package:flutter/material.dart';
import 'package:mmg/app/auth/view/login_screen.dart';
import 'package:mmg/app/home/widgets/box_container.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: Responsive.height * 36,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage(AppImages.homeScreenBackGroundImage),
                            fit: BoxFit.cover)),
                  ),
                  Positioned(
                      top: 39,
                      child: Image.asset(
                        AppImages.blakLogo,
                        color: Colors.black,
                        width: 70.59,
                        height: 70.59,
                      )),
                  const Positioned(
                      top: 100,
                      child: Column(
                        children: [
                          Text(
                            'Move My Goods',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Digital Logistic Platform',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 10.89,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      )),
                  Positioned(
                    top: 214,
                    child: Image.asset(
                      AppImages.truckImage,
                      width: 359,
                      height: 197,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 98,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 46,
                      childAspectRatio: 8 / 6),
                  itemBuilder: (context, int index) {
                    return SmallBoxontainerWidget(
                        numberColor: index == 0
                            ? const Color(0xffab00af)
                            : index == 1
                                ? const Color(0xff006eef)
                                : index == 2
                                    ? const Color(0xff847f00)
                                    : index == 3
                                        ? const Color(0xff00c108)
                                        : index == 4
                                            ? const Color(0xff009ba4)
                                            : index == 5
                                                ? const Color(0xffDF0E0E)
                                                : null);
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonWidgets(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                  // context.push(const LoginScreen());
                },
              ),
            ],
          ),
        ));
  }
}
