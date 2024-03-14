import 'package:dio/dio.dart';
import 'package:mmg/app/utils/backend/interceptor.dart';

class Urls {
  static const baseUrl = 'http://103.160.153.57:8087/mmg/api';
  static const imageBaseUrl = 'https://storage.googleapis.com/admin-mmg/';
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
  final onboardUser = "http://103.160.153.57:8083/mmg/api/v2/login";
  final onboardSignUpUser =
      "http://103.160.153.57:8083/mmg/api/v2/profile/sms/otp";
  final verifyOtpOnboard =
      "http://103.160.153.57:8083/mmg/api/v2/profile/validateOtp";
  final validateForgotOtpOnboard = "$baseUrl/auth/validate-otp";
  final onboardForgetPassword = "$baseUrl/auth/forgot-password";
  final onboardResendOtp = "$baseUrl/auth/resend-otp";
  final createprofile = '$baseUrl/user-profile/create';
  final getAllProfile = '$baseUrl/user-profile/all';

  /* BOOKING */
  final bookingCount = "$baseUrl/v1/dashboard/booking/profile";
  final bookingByStatus = "$baseUrl/v2";

  final countryUrl = "http://103.160.153.57:8085/mmg/api/v1/country";
  final bookingDetails = "$baseUrl/v2/booking";
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
