import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mmg/app/utils/apppref.dart';

class HttpServerClient {
  static const int _timeout = 1800;

  /// Get request

  static get() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AppPref.userToken}',
      'x-api-key': 'MMGATPL'
    };
    log('message');

    try {
      var response = await http
          .get(
              Uri.parse(
                  "http://103.160.153.57:8087/mmg/api/v2/downloadInvoice/booking/711950406874"),
              headers: headers)
          .timeout(const Duration(seconds: _timeout));
      log('message ${response.body}');
      return response.body;
    } on SocketException {
      log('aaaaaaaaaaaaaaaaaaaaaaa');
      return [600, "No internet"];
    } catch (e) {
      log(e.toString());
      return [600, e.toString()];
    }
  }

  static Future<List> _response(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return [response.statusCode, jsonDecode(response.body)];
      case 201:
        return [response.statusCode, jsonDecode(response.body)];
      case 400:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 401:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 403:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 404:
        return [response.statusCode, "You're using unregistered application"];
      case 500:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 503:
        return [response.statusCode, jsonDecode(response.body)["message"]];
      case 504:
        return [
          response.statusCode,
          {"message": "Request timeout", "code": 504, "status": "Cancelled"}
        ];
      default:
        return [response.statusCode, jsonDecode(response.body)["message"]];
    }
  }
}
