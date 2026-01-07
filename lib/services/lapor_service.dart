import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaporService {
  final Dio _dio = Dio();
  final String baseUrl = "http://10.0.2.2:8000/api";

  // Fungsi Kirim Laporan
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      FormData formData = FormData.fromMap({
        'notelp': telp,
        'date': tanggal,
        'time': jam,
        'polres': polres,
        'alamat': alamat,
        'deskripsi': deskripsi,
      });

      if (filePath != null) {
        formData.files.add(MapEntry('foto', await MultipartFile.fromFile(filePath)));
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
    } catch (e) {
      return false;
    }
  }

  // Fungsi Ambil Riwayat Laporan
  Future<List<dynamic>> getRiwayatLaporan() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth_token');

      final response = await _dio.get(
        '$baseUrl/laporan',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        }),
      );
      return response.data;
    } catch (e) {
      return [];
    }
  }
}