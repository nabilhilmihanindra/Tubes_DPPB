import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio();
  // IP Khusus Emulator Android
  final String baseUrl = "http://10.0.2.2:8000/api";

  // Ambil Token dari memori HP
  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // FUNGSI KIRIM LAPORAN
  Future<bool> kirimLaporan({
    required String alamat,
    required String polres,
    required String telp,
    required String tanggal,
    required String jam,
    required String deskripsi,
    String? filePath,
  }) async {
    try {
      String? token = await _getToken();
      
      // SESUAIKAN KEY DENGAN LAPORANAPICONTROLLER LARAVEL
      FormData formData = FormData.fromMap({
        'notelp': telp,        // Sesuai Laravel
        'date': tanggal,       // Sesuai Laravel
        'time': jam,          // Sesuai Laravel
        'polres': polres,      // Sesuai Laravel
        'alamat': alamat,      // Sesuai Laravel
        'deskripsi': deskripsi, // Sesuai Laravel
      });

      if (filePath != null) {
        formData.files.add(MapEntry(
          'foto', // Sesuai Laravel
          await MultipartFile.fromFile(filePath),
        ));
      }

      final response = await _dio.post(
        '$baseUrl/laporan',
        data: formData,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );

      return response.statusCode == 201 || response.statusCode == 200;
    } on DioException catch (e) {
      // DEBUG: Lihat pesan error dari Laravel jika masih gagal
      print("DETAIL ERROR: ${e.response?.data}");
      return false;
    }
  }

  // FUNGSI AMBIL NOTIFIKASI
  Future<List<dynamic>> getNotifications() async {
    try {
      String? token = await _getToken();
      final response = await _dio.get(
        '$baseUrl/notifications',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );
      return response.data; 
    } catch (e) {
      print("Error Notif: $e");
      return [];
    }
  }
}