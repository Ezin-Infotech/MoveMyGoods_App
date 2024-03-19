import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/bookings/model%20view/booking_provider.dart';
import 'package:mmg/app/home/view%20model/home_provider.dart';
import 'package:mmg/app/home/view/widgets/box_container.dart';
import 'package:mmg/app/utils/app%20style/app_images.dart';
import 'package:mmg/app/utils/app%20style/colors.dart';
import 'package:mmg/app/utils/app%20style/responsive.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/common%20widgets/button.dart';
import 'package:mmg/app/utils/enums.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showcaseview/showcaseview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    if (AppPref.userToken != '') {
      context.read<HomeProvider>().getBookingCountFn();
      context.read<BookingProvider>().getGoodsTypeFn();

      context.read<AuthProvider>().getUserProfilePicFn();
      context.read<AuthProvider>().getUserProfileDetailsFn();
    }
    context.read<AuthProvider>().getCountryFn(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: Responsive.height * 38,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImages.homeScreenBackGroundImage),
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  top: 39,
                  child: Image.asset(
                    AppImages.blakLogo,
                    color: Colors.pink,
                    width: 70.59,
                    height: 70.59,
                  )),
              Positioned(
                  top: 102,
                  child: Column(
                    children: [
                      Text(
                        'Move My Goods',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
            height: 118,
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
                  childAspectRatio: 8 / 6.5),
              itemBuilder: (context, int index) {
                return Consumer<AuthProvider>(builder: (context, auth, _) {
                  return Consumer<HomeProvider>(builder: (context, value, _) {
                    return auth.isUserLogged
                        ? value.getAllBookingCountStatus ==
                                GetAllBookingCountStatus.loading
                            ? Shimmer.fromColors(
                                baseColor: Colors.grey.shade500,
                                highlightColor: Colors.grey.shade500,
                                direction: ShimmerDirection.btt,
                                period: const Duration(milliseconds: 1000),
                                child: Container(
                                  width: 105,
                                  height: 75,
                                  decoration: const BoxDecoration(
                                      color: Color(0xffE8E8E8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromARGB(
                                              145, 158, 158, 158),
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                ))
                            :
                            // const SizedBox(
                            //     width: 50,
                            //     height: 50,
                            //     child: Center(
                            //       child: CircularProgressIndicator(),
                            //     ),
                            //   )
                            Showcase(
                                key: index == 0
                                    ? value.globalKey1
                                    : index == 1
                                        ? value.globalKey2
                                        : index == 2
                                            ? value.globalKey3
                                            : index == 3
                                                ? value.globalKey4
                                                : index == 4
                                                    ? value.globalKey5
                                                    : value.globalKey6,
                                description: index == 0
                                    ? value.descriptions[index]
                                    : index == 1
                                        ? value.descriptions[index]
                                        : index == 2
                                            ? value.descriptions[index]
                                            : index == 3
                                                ? value.descriptions[index]
                                                : index == 4
                                                    ? value.descriptions[index]
                                                    : value.descriptions[index],
                                child: SmallBoxontainerWidget(
                                  subTitle: value.bookingCountData.data == null
                                      ? '0'
                                      : index == 0
                                          ? value.bookingCountData.data!.total
                                              .toString()
                                          : index == 1
                                              ? value
                                                  .bookingCountData.data!.total
                                                  .toString()
                                              : index == 2
                                                  ? value.bookingCountData.data!
                                                      .pending
                                                      .toString()
                                                  : index == 3
                                                      ? value.bookingCountData
                                                          .data!.active
                                                          .toString()
                                                      : index == 4
                                                          ? value
                                                              .bookingCountData
                                                              .data!
                                                              .completed
                                                              .toString()
                                                          : index == 5
                                                              ? value
                                                                  .bookingCountData
                                                                  .data!
                                                                  .cancelled
                                                                  .toString()
                                                              : "0",
                                  title: value.bookingTiltes[index],
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
                                                          ? const Color(
                                                              0xffDF0E0E)
                                                          : null,
                                ),
                              )
                        : SmallBoxontainerWidget(
                            subTitle: '0',
                            title: value.bookingTiltes[index],
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
                                                    : null,
                          );
                  });
                });
              },
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Showcase(
            key: context.read<HomeProvider>().globalKey7,
            description: 'Take Order',
            child: ButtonWidgets(
              onPressed: () {
                if (AppPref.userToken != '') {
                  context
                      .read<BookingProvider>()
                      .changeShowRecieverDetails(isShow: false);
                  context.read<BookingProvider>().clearBooingVariables();
                  Get.toNamed(AppRoutes.bookingScreen);
                } else {
                  Get.toNamed(AppRoutes.login);
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
