import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mmg/app/auth/modal/country_model.dart';

import 'package:mmg/app/utils/backend/urls.dart';

class AuthServices extends Urls {
  /* Dashboard Booking Count */
  Future postSignInService({
    required String email,
    required String password,
  }) async {
    final response = await dio.post(
      onboardUser,
      options: Options(
        headers: {'Content-Type': 'application/json', 'x-api-key': 'MMGATPL'},
      ),
      data: {"userName": email, "password": password, "roleId": 1},
    );
    // print(response);
    return response.data;
  }

  Future postSignUpOtpService({
    required String email,
    required String phone,
  }) async {
    final response = await dio.post(
      onboardSignUpUser,
      options: Options(
        headers: {'Content-Type': 'application/json', 'x-api-key': 'MMGATPL'},
      ),
      data: {"mobileNumber": phone, "emailId": email, "roleId": 1},
    );
    // print(response);
    return response.data;
  }

  Future postVerifyOtpService({
    required String phone,
    required String otp,
  }) async {
    final response = await dio.post(
      verifyOtpOnboard,
      options: Options(
        headers: {'Content-Type': 'application/json', 'x-api-key': 'MMGATPL'},
      ),
      data: {"otp": otp, "mobileNumber": phone},
    );
    // print(response);
    return response.data;
  }

  Future<CountryModel> getCountryService() async {
    final response = await dio.get(countryUrl,
        options: Options(
          headers: {'Content-Type': 'application/json', 'x-api-key': 'MMGATPL'},
        ));
    // print(response);
    return countryModelFromJson(jsonEncode(response.data));
  }
}
