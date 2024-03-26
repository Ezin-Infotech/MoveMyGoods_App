// Future postUploadImageService({
//     required dynamic image,
//   }) async {
//     // Define your form data

//     // Encode form data
//     var body = formData.entries.map((entry) {
//       return '${entry.key}=${Uri.encodeQueryComponent(entry.value)}';
//     }).join('&');
//     final response = await dio.post(
//       uploadImageUrl,
//       options: Options(
//         headers: {
//           'Content-Type': 'application/x-www-form-urlencoded',
//           'x-api-key': 'MMGATPL'
//         },
//       ),
//       data: body,
//     );
//     print(response);
//     return response.data;
//   }
import 'package:http/http.dart' as http;
import 'package:mmg/app/utils/apppref.dart';

void postData({required dynamic file}) async {
  // Define your form data
  Map formData = {
    'file': file,
    'profileId': AppPref.userProfileId,
    'category': "PROFILE",
    'update': "true",
    // Add more key-value pairs as needed
  };

  // Create a new multipart request
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://103.160.153.57:8083/mmg/api/v2/image/role/1'));

  // Add form data to the request
  formData.forEach((key, value) {
    request.fields[key] = value;
  });
  // Add 'x-api-key' to headers
  request.headers['x-api-key'] = 'MMGATPL';
  request.headers['Content-Type'] =
      'multipart/form-data; boundary=----WebKitFormBoundaryJ77qtB184FNARSSx';
  // Send the request
  try {
    var streamedResponse = await request.send();
    if (streamedResponse.statusCode == 200) {
      // Request was successful, handle response here
      var response = await http.Response.fromStream(streamedResponse);
      print('Response: ${response.body}');
    } else {
      // Request failed, handle errors here
      print('Request failed with status: ${streamedResponse.statusCode}');
    }
  } catch (e) {
    print('Request failed with status: $e');
  }

  // Check response status
}
