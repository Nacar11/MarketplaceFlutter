// // ignore_for_file: file_names

// import 'package:get_storage/get_storage.dart';
// import 'package:dio/dio.dart';

// Dio createDioWithInterceptor() {
//   final dio = Dio();

//   String? getTokenFromStorage() {
//     final storage = GetStorage();
//     return storage.read('token');
//   }

//   String? token = getTokenFromStorage();

//   dio.interceptors.add(InterceptorsWrapper(
//     onRequest: (options, handler) {
//       // Modify the request before sending it
//       options.headers['Authorization'] =
//           token; // Replace with your authentication token
//       handler.next(options);
//     },
//   ));

//   return dio;
// }
