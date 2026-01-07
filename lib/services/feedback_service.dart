import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeedbackService {
  final Dio _dio = Dio();
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<bool> kirimFeedback({
    required String nama,
    required String email,
    required String notelp,
    required String deskripsi,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      final response = await _dio.post(
        '$baseUrl/feedback',
        data: {
          'nama': nama,       // Sesuai $request->nama
          'email': email,     // Sesuai $request->email
          'notelp': notelp,   // Sesuai $request->notelp
          'deskripsi': deskripsi, // Sesuai $request->deskripsi
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Error Detail Feedback: $e");
      return false;
    }
  }
}