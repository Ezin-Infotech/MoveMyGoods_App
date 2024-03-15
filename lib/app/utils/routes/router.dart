import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmg/app/auth/view/forget_password.dart';
import 'package:mmg/app/auth/view/forget_password_second_page.dart';
import 'package:mmg/app/auth/view/login_screen.dart';
import 'package:mmg/app/auth/view/otp_screen.dart';
import 'package:mmg/app/auth/view/profile_screen.dart';
import 'package:mmg/app/auth/view/sign_up.dart';
import 'package:mmg/app/bookings/view/booking_details_screen.dart';
import 'package:mmg/app/bookings/view/booking_screen.dart';
import 'package:mmg/app/bookings/view/booking_success_completed.dart';
import 'package:mmg/app/home/view/home_inner_booking_screen.dart';
import 'package:mmg/app/home/view/showcase/showcasewidget.dart';
import 'package:mmg/app/splash/view/splash_screen.dart';
import 'package:mmg/app/utils/common%20widgets/no_internet_screen.dart';
import 'package:mmg/app/utils/routes/route_names.dart';
import 'package:page_transition/page_transition.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final url = settings.name;
    final args = settings.arguments;

    switch (url) {
      case "/":
        return pagetransition(
          settings: settings,
          widget: const SplashScreen(),
        ); //SplashScreen
      case AppRoutes.loginOrHome:
        return pagetransition(
          settings: settings,
          widget: const MyShowCaseWidget(),
        ); //
      case AppRoutes.bookingSuccessFullycompleted:
        return pagetransition(
          settings: settings,
          widget: const BookingSuccessFullyCompletedScreen(),
        ); //

      case AppRoutes.login:
        return pagetransition(
          settings: settings,
          widget: const LoginScreen(),
        ); //
      case AppRoutes.signUp:
        return pagetransition(
          settings: settings,
          widget: const SignUpScreen(),
        );
      case AppRoutes.otpScreen:
        return pagetransition(
          settings: settings,
          widget: const OtpScreen(),
        ); //

      case AppRoutes.noInternetScreen:
        return pagetransition(
          settings: settings,
          widget: const NoInternetScreen(),
        );
      case AppRoutes.bookingScreen:
        return pagetransition(
          settings: settings,
          widget: const BookingScreen(),
        );
      case AppRoutes.homeBookingListScreen:
        return pagetransition(
          settings: settings,
          widget: const HomeBookingListScreen(),
        );
      case AppRoutes.signUpProfileScreen:
        return pagetransition(
          settings: settings,
          widget: const SignUpProfileScreen(),
        );
      case AppRoutes.completedBookingScreen:
        return pagetransition(
          settings: settings,
          widget: const CompletedBookingScreen(),
        );
      case AppRoutes.bookingSuccessFullyCompletedScreen:
        return pagetransition(
          settings: settings,
          widget: const BookingSuccessFullyCompletedScreen(),
        );
      case AppRoutes.forgetPasswordPage:
        return pagetransition(
          settings: settings,
          widget: const forgetPasswordScreen(),
        );
      case AppRoutes.forgetPasswordEnterPage:
        return pagetransition(
          settings: settings,
          widget: const ForgetPaswordEnterScreen(),
        );
    }
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
              body: Center(child: Error()),
            ));
  }

  static PageTransition<dynamic> pagetransition({
    required RouteSettings settings,
    required Widget widget,
    Bindings? binding,
  }) {
    if (binding != null) {
      binding.dependencies();
    }
    return PageTransition(
      child: widget,
      type: PageTransitionType.rightToLeftWithFade,
      settings: settings,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  static PageTransition<dynamic> pagetransitionLeft({
    required RouteSettings settings,
    required Widget widget,
    Bindings? binding,
  }) {
    if (binding != null) {
      binding.dependencies();
    }
    return PageTransition(
      child: widget,
      type: PageTransitionType.bottomToTop,
      settings: settings,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }
}

class Error extends StatelessWidget {
  const Error({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return const Text('Oops');
  }
}
