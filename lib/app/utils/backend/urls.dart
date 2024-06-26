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
  final getTermsAndCondition =
      "http://103.160.153.57:8085/mmg/api/v1/terms/conditions/role/1?isActive=true";

  final validateForgotOtpOnboard = "$baseUrl/auth/validate-otp";
  final onboardForgetPassword = "$baseUrl/auth/forgot-password";
  final onboardResendOtp = "$baseUrl/auth/resend-otp";
  final createprofile = '$baseUrl/user-profile/create';
  final getAllProfile = '$baseUrl/user-profile/all';

  /* BOOKING */
  final bookingCount = "$baseUrl/v1/dashboard/booking/profile";
  final bookingByStatus = "$baseUrl/v2";
  final downloadBookingInvoice =
      "http://103.160.153.57:8087/mmg/api/v2/downloadInvoice/booking/";
  final countryUrl = "http://103.160.153.57:8085/mmg/api/v1/country";
  final stateUrl = "http://103.160.153.57:8085/mmg/api/v1/State/country";
  final cityUrl = "http://103.160.153.57:8085/mmg/api/v1/city";

  final bookingDetails = "$baseUrl/v2/booking";
  final goodsTypeUrl = "http://103.160.153.57:8085/mmg/api/v1/goodsType";
  final goodsWeightUrl =
      "http://103.160.153.57:8090/mmg/api/v1/fare/calculation/weight";
  final goodsVehicleUrl =
      "http://103.160.153.57:8086/mmg/api/v2/vehicle/nearest";
  final bookingFarePriceUrl =
      "http://103.160.153.57:8087/mmg/api/v2/booking/fare";
  final confirmBookingUrl = "http://103.160.153.57:8087/mmg/api/v2/booking";
  final cancelBookingUrl =
      "http://103.160.153.57:8087/mmg/api/v2/booking/status";
  final userProfileImage = "http://103.160.153.57:8083/mmg/api/v2/image";
  final userProfileDetails = 'http://103.160.153.57:8083/mmg/api/v2/profile';
  final createProfile = 'http://103.160.153.57:8083/mmg/api/v2/profile';
  final changePhoneGetOtp =
      'http://103.160.153.57:8083/mmg/api/v2/profile/sms/otp';
  final validatePhoneGetOtp =
      'http://103.160.153.57:8083/mmg/api/v2/profile/validateOtp';
  final forgotPasswordGetOtp =
      'http://103.160.153.57:8083/mmg/api/v2/profile/forgotpassword/mobile';
  final updatePassWord =
      'http://103.160.153.57:8083/mmg/api/v2/profile/password';
  final uploadImageUrl = 'http://103.160.153.57:8083/mmg/api/v2/image/role/1';
}
