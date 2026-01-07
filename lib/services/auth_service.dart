// lib/services/auth_service.dart
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final Dio _dio = Dio();
  final String baseUrl = "http://10.0.2.2:8000/api";

  // Fungsi Register
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await _dio.post('$baseUrl/register', data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password,
      });
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      print("Register Error: $e");
      return false;
    }
  }

  // Fungsi Login (Wajib simpan token)
  Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post('$baseUrl/login', data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', response.data['token']); // Ambil token
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}