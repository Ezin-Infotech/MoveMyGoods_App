import 'package:dio/dio.dart';
import 'package:mmg/app/utils/backend/interceptor.dart';

class Urls {
  static const baseUrl = 'http://103.160.153.57:8087/mmg/api';

  void statuscode(Response<dynamic> response, double code) {
    if (response.statusCode != code) {
      throw Exception(response.data);
    }
  }

  Dio dio = Dio(BaseOptions(
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 12000),
      receiveTimeout: const Duration(milliseconds: 12000)))
    ..interceptors.add(
      ApiInterceptor(),
    );
  /* ONBOARDING */
  final onboardUser = "$baseUrl/auth/sign-in";
  final onboardSignUpUser = "$baseUrl/auth/sign-up";
  final verifyOtpOnboard = "$baseUrl/auth/verify-email";
  final validateForgotOtpOnboard = "$baseUrl/auth/validate-otp";
  final onboardForgetPassword = "$baseUrl/auth/forgot-password";
  final onboardResendOtp = "$baseUrl/auth/resend-otp";
  final createprofile = '$baseUrl/user-profile/create';
  final getAllProfile = '$baseUrl/user-profile/all';

  /* PHARMA */
  final bookingCount = "$baseUrl/v1/dashboard/booking/profile";
  final pharmaSingleProduct = "$baseUrl/product/single";

  final pharmaLatestProducts = "$baseUrl/product/pharma";
  final pharmaCartProducts = "$baseUrl/cart/";
  final pharmaCartAddOrRemove = "$baseUrl/cart/";
  final pharmaCartProductRemove = "$baseUrl/cart/remove-from-cart/";
  final pharmaFavoriteProducts = "$baseUrl/favourites/";
  final pharmaOrders = "$baseUrl/order/pharma/orders";

  final pharmaSubCategory = '$baseUrl/sub-categories/';
  final pharmaSubCategoryProduct = '$baseUrl/product/sub-category/';
  final pharmaCategoryProducts = '$baseUrl/product/all-products/';
  final applyCoupon = '$baseUrl/coupon/apply';
  final getUserCoupon = '$baseUrl/coupon/get-all';
  final getUserAllAdress = '$baseUrl/address';
  final cartCheckout = '$baseUrl/order';
  final createAdd = '$baseUrl/address/create';
  final updateAdd = '$baseUrl/address/update';
  final pharmaSearch = '$baseUrl/product/pharma';
}
