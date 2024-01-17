import 'package:http/http.dart' as http;
import 'package:marketplacedb/util/local_storage/local_storage.dart';

MPLocalStorage localStorage = MPLocalStorage();

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
    return localStorage.readData('token');
  }
}
