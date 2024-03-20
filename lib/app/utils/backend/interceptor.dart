// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mmg/app/auth/view%20model/auth_provider.dart';
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/routes/route_names.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool isConnected = await checkInternetConnectivity();

    if (!isConnected) {
      Get.toNamed(AppRoutes.noInternetScreen);
    } else {
      return handler.next(options);
    }
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // log("❌🌍❌ Error [${err.response?.statusCode}] => ${err.requestOptions.path} | Details: ${err.response?.data}");
    log(err.response?.data['message']);
    // ignore: unused_local_variable
    final isInvalidUser = err.response?.statusCode == 401 &&
        err.response!.data['message']
            .toString()
            .contains("Invalid access token:");
    if (err.message == 'The connection errored: Network is unreachable') {
      Get.toNamed(AppRoutes.noInternetScreen);
    }
    if (isInvalidUser) {
      log('invaliiiiiiiiiiiiiiiiiiiiiiiiiiid');
      AppPref.userToken = '';
      AuthProvider().checkIsUserLoggedOnCacheFn();
      AuthProvider().isUserLoggedFn(isLogged: false);
      // auth.signOut();
      // Get.offAllNamed(AppRoutes.login);

      handler.resolve(
          Response(statusCode: 200, requestOptions: err.requestOptions));
    }
    handler.next(err);
  }

  // //FIt Bit access ttoken interceptor
  // ApiInterceptor();
  // void onAccessTokenError(DioError err, ErrorInterceptorHandler handler) async {
  //   // Log the error
  //   log("❌🌍❌ Error [${err.response?.statusCode}] => ${err.requestOptions.path} | Details: ${err.response?.data}");

  //   // Check if the error is due to an expired access token
  //   if (err.response!.statusCode! >= 203) {
  //     // Attempt to refresh the token here
  //     try {
  //       // Call your method to refresh the access token
  //       String newAccessToken = await refreshAccessToken();

  //       // If the refresh was successful, retry the original request with the new token
  //       RequestOptions requestOptions = err.requestOptions;
  //       requestOptions.headers["Authorization"] = "Bearer $newAccessToken";
  //       Urls().dio.fetch(requestOptions).then(
  //             (r) => handler.resolve(r),
  //             onError: (e) => handler.next(e),
  //           );
  //     } catch (e) {
  //       // If token refresh fails, proceed with the original error
  //       handler.next(err);
  //     }
  //   } else if (err.message ==
  //       'The connection errored: Network is unreachable') {
  //     Get.toNamed(AppRoutes.noInternetScreen);
  //   } else {
  //     // For all other errors, just forward them
  //     handler.next(err);
  //   }
  // }

  Future<String> refreshAccessToken() async {
    // Implement token refresh logic here
    // This should include making a request to your backend to get a new access token
    // and updating any stored token values in your application
    return "new_access_token"; // Placeholder return
  }

  Future<bool> checkInternetConnectivity() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
