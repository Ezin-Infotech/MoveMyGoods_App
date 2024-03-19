import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

getAddressFromLatLng(context, double lat, double lng) async {
  const String apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';
  String host = 'https://maps.google.com/maps/api/geocode/json';
  final url = '$host?key=$apiKey&language=en&latlng=$lat,$lng';
  print("response ==== $url");
  try {
    print("response ==== try");
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("response ====1 ${response.body}");
      Map data = jsonDecode(response.body);
      log("response ==== ${data["results"][0]}");
      String formattedAddress = data["results"][0]["formatted_address"];
      print("response ==== $formattedAddress");
      return data["results"];
    } else {
      return null;
    }
  } catch (e) {
    print("response ==== $e");
  }
}

// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:mmg/app/bookings/model/country_details.dart';

// Future<CountryDetailsModel> getAddressFromLatLng(
//     context, double lat, double lng) async {
//   const String apiKey = 'AIzaSyBOHuJ-4CqJBjmSi_RugeonwPU5cBVqbeA';
//   String host = 'https://maps.google.com/maps/api/geocode/json';
//   final url = '$host?key=$apiKey&language=en&latlng=$lat,$lng';
//   print("response ==== $url");
//   try {
//     print("response ==== try");
//     var response = await http.get(Uri.parse(url));
//     if (response.statusCode == 200) {
//       print("response ====1 ${response.body}");
//       // Map data = jsonDecode(response.body);
//       // log("response ==== ${data["results"][0]}");
//       // String formattedAddress = data["results"][0]["formatted_address"];
//       // print("response ==== $formattedAddress");
//       return countryDetailsModelFromJson(jsonEncode(response.body));
//     } else {
//       return CountryDetailsModel();
//     }
//   } catch (e) {
//     print("response ==== $e");
//     return CountryDetailsModel();
//   }
// }

