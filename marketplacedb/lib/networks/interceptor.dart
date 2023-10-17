import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class AuthInterceptor extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    String? token = getTokenFromStorage();

    if (token != null) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    return _inner.send(request);
  }

  String? getTokenFromStorage() {
    final storage = GetStorage();
    return storage.read('token');
  }
}
