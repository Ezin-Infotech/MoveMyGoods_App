import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mmg/app/auth/modal/country_model.dart';
import 'package:mmg/app/auth/modal/profile_model.dart';
import 'package:mmg/app/auth/modal/user_profile_picture_model.dart';
import 'package:mmg/app/utils/apppref.dart';
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
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    // print(response);
    return countryModelFromJson(jsonEncode(response.data));
  }

  Future<ProfileDataModel> getProfileDetailService() async {
    final response = await dio.get(countryUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    // print(response);
    return profileDataModelFromJson(jsonEncode(response.data));
  }

  Future<UserProfilePicModel> getUserProfilePicService() async {
    final response = await dio.get(
        '$userProfileImage/${AppPref.userProfileId}?category=PROFILE&roleId=1',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    // print(response);
    return userProfilePicModelFromJson(jsonEncode(response.data));
  }
}
