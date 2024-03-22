import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// final urlToUploadImage = Uri.parse('https://10.0.2.2/predict_image');

// final urlToUploadImage = Uri.parse('http://127.0.0.1:8000/identify_svm');
final urlToUploadImage =
    Uri.parse('https://c141-196-190-62-74.ngrok-free.app/identify_svm');

Future<Map<String, dynamic>> uploadImage(File image) async {
  var request = http.MultipartRequest('POST', urlToUploadImage);
  request.files.add(
    await http.MultipartFile.fromPath(
      'image',
      image.path,
    ),
  );

  try {
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var responseData = jsonDecode(responseBody);
      return responseData;
    } else {
      print('Error: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('Error: $e');
    return {};
  }
}
