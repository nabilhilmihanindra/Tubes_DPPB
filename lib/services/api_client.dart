import 'package:dio/dio.dart';

class ApiClient {
  // Gunakan 10.0.2.2 untuk emulator Android
  static const String baseUrl = "http://10.0.2.2:8000/api";
  
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));
}