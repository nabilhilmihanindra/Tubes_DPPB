import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  final Dio _dio = Dio();
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<dynamic>> getNotifications() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      final response = await _dio.get(
        '$baseUrl/notifications',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );
      return response.data; // Mengambil list notifikasi dari Laravel
    } catch (e) {
      print("Error Notif: $e");
      return [];
    }
  }
}