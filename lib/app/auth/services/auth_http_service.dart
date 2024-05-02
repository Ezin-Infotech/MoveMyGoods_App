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
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mmg/app/utils/apppref.dart';
import 'package:mmg/app/utils/common%20widgets/dialogs.dart';
import 'package:path_provider/path_provider.dart';

postData({required File files}) async {
  // Create a new multipart request
  File profileImage;
  String profileUrl;
  String path = '';
  var fileSize = await files.length();
  if (!RegExp(r'(\.jpg|\.jpeg|\.png)$', caseSensitive: false)
      .hasMatch(files.path)) {
    failurtoast(title: "Invalid file type, please upload the proper image");
    return;
  }
  if (fileSize > 1000000) {
    failurtoast(title: "Image size must be less than or equal to 1 Mb");
  } else {
    // Get the path where the file will be saved
    Directory appDocDir = await getApplicationDocumentsDirectory();
    path = '${appDocDir.path}/${files.path.split('/').last}';

    // Copy the selected file to the app's documents directory
    File copiedFile = await files.copy(path);
    profileImage = copiedFile;
    profileUrl = copiedFile.path;
  }
  var request = http.MultipartRequest(
      'POST', Uri.parse('http://103.160.153.57:8083/mmg/api/v2/image/role/1'));

  request.fields['profileId'] = AppPref.userProfileId; // Add profileId
  request.fields['category'] = "PROFILE"; // Add category
  request.fields['update'] = "true"; // Add update
  var file = await http.MultipartFile.fromPath('file', path);
  request.files.add(file);

  // request.files.add(await http.MultipartFile.fromPath('file', file.path));
  // Add 'x-api-key' to headers
  request.headers['x-api-key'] = 'MMGATPL';
  request.headers['Content-Type'] =
      'multipart/form-data; boundary=----WebKitFormBoundaryJ77qtB184FNARSSx';
  // Send the request
  try {
    var streamedResponse = await request.send();

    // Request was successful, handle response here
    var response = await http.Response.fromStream(streamedResponse);
    print('Responsewwwwwwwwwwwwwwwwwwwwwwwwww: ${response.body}');
  } catch (e) {
    print('Request failed with status: $e');
  }

  // Check response status
}
