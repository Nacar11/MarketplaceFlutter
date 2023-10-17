import 'dart:io';
import 'dart:convert';
import 'package:get/get_connect/connect.dart';
import 'package:http/http.dart' as http;
import 'package:marketplacedb/constants/constant.dart';

class ImageUploadProvider extends GetConnect {
  Future<String> uploadImage(List<String> list) async {
    try {
      //fill in the blanks
      var form = 0;
      final response =
          await post("http://localhost:8000/api/imageUpload", form);

      if (response.status.hasError) {
        print(Future.error(response.body));
      } else {
        print("pass through here");
        return response.body;
      }
      return response.body;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<void> imageUpload(File imageFile) async {
    final uri = Uri.parse(
        '${url}imageUpload'); // Replace with your Laravel endpoint URL

    final request = http.MultipartRequest('POST', uri);

    request.headers['Accept'] = 'application/json';
    request.files.add(http.MultipartFile(
      'File', // This should match the parameter name in your Laravel controller
      http.ByteStream.fromBytes(imageFile.readAsBytesSync()),
      imageFile.lengthSync(),
      filename: 'image.jpg', // You can change the filename if needed
    ));

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('File upload failed');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }
}
