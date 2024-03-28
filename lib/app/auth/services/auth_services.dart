import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mmg/app/auth/modal/city_list_model.dart';
import 'package:mmg/app/auth/modal/country_model.dart';
import 'package:mmg/app/auth/modal/profile_model.dart';
import 'package:mmg/app/auth/modal/state_list_model.dart';
import 'package:mmg/app/auth/modal/terms_n_condition_model.dart';
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
    print(response);
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
    print(response);
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
    print(response);
    return response.data;
  }

  Future forgotPasswordSendOtpService({
    required String phone,
  }) async {
    final response = await dio.get(
      '$forgotPasswordGetOtp/$phone',
      options: Options(
        headers: {'Content-Type': 'application/json', 'x-api-key': 'MMGATPL'},
      ),
    );
    return response.data;
  }

  Future updatePassWordService({
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    final response = await dio.put(
      updatePassWord,
      options: Options(
        headers: {'Content-Type': 'application/json', 'x-api-key': 'MMGATPL'},
      ),
      data: {
        "password": password,
        "confirmPassword": confirmPassword,
        "mobileNumber": phone
      },
    );
    return response.data;
  }

  Future<CountryModel> getCountryService() async {
    final response = await dio.get(countryUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    print(response);
    return countryModelFromJson(jsonEncode(response.data));
  }

  Future<GetTermsNConditionModel> getTermsNConditionService() async {
    final response = await dio.get(getTermsAndCondition,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    print(response);
    return getTermsNConditionModelFromJson(jsonEncode(response.data));
  }

  Future<ProfileDataModel> getProfileDetailService() async {
    final response =
        await dio.get("$userProfileDetails/${AppPref.userProfileId}?roleId=1",
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${AppPref.userToken}',
                'x-api-key': 'MMGATPL'
              },
            ));
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
    return userProfilePicModelFromJson(jsonEncode(response.data));
  }

  Future<CityListModel> getCityService({required String stateId}) async {
    final response = await dio.get('$cityUrl/$stateId',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    return cityListModelFromJson(jsonEncode(response.data));
  }

  Future<StateListModel> getStateService({required String countryId}) async {
    final response = await dio.get("$stateUrl/$countryId",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // 'Authorization': 'Bearer ${AppPref.userToken}',
            'x-api-key': 'MMGATPL'
          },
        ));
    return stateListModelFromJson(jsonEncode(response.data));
  }

  Future postCreateProfileService({
    required dynamic data,
  }) async {
    final response = await dio.post(
      createProfile,
      options: Options(
        headers: {'Content-Type': 'application/json', 'x-api-key': 'MMGATPL'},
      ),
      data: data,
    );
    return response.data;
  }

  Future putUpdateProfileService({
    required dynamic data,
  }) async {
    final response = await dio.put(
      createProfile,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppPref.userToken}',
          'x-api-key': 'MMGATPL'
        },
      ),
      data: data,
    );
    return response.data;
  }

  // Future postUploadImageService({
  //   required dynamic image,
  //   required dynamic imageName,
  // }) async {
  //   // Define your form data

  //   FormData formData = FormData.fromMap({
  //     'profileId': AppPref.userProfileId,
  //     'category': "PROFILE",
  //     'update': true,
  //     'file': await MultipartFile.fromFile(image, filename: imageName),
  //     // Add more fields or files as needed
  //   });

  //   // Encode form data

  //   final response = await dio.post(
  //     uploadImageUrl,
  //     options: Options(
  //       headers: {
  //         'Content-Type': 'application/x-www-form-urlencoded',
  //         'x-api-key': 'MMGATPL'
  //       },
  //     ),
  //     data: formData,
  //   );
  //   print("1111111111111111111111111111111111111111111111 ${response}");
  //   return response.data;
  // }
  Future postUploadImageService({
    required File file,
    required dynamic imageName,
  }) async {
    // Define your form data
    log('${file.path}1111111111');
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: imageName),
      'profileId': AppPref.userProfileId,
      'category': "PROFILE",
      'update': "true",
    });

    // Encode form data

    final response = await dio.post(
      uploadImageUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer ${AppPref.userToken}',
          'Content-Type': 'application/x-www-form-urlencoded',
          'x-api-key': 'MMGATPL'
        },
      ),
      data: formData,
    );
    print("1111111111111111111111111111111111111111111111 ${response.data}");
    return response.data;
  }
}
