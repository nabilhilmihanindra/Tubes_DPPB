import 'package:flutter/material.dart';
import '../../services/notification_service.dart';

class NotifPage extends StatefulWidget {
  const NotifPage({super.key});

  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  final NotificationService _notificationService = NotificationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1C2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          "Notifikasi",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _notificationService.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.white));
          }

          final listNotif = snapshot.data ?? [];

          if (listNotif.isEmpty) {
            return const Center(
              child: Text("Tidak ada notifikasi", style: TextStyle(color: Colors.white70)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: listNotif.length,
            itemBuilder: (context, index) {
              final item = listNotif[index];
              
              // Logika: Jika ada data laporan terkait, tampilkan detailnya
              return NotificationCard(
                title: "Status Laporan",
                message: item['message'] ?? "Pembaruan pada laporan Anda",
                time: item['created_at'] ?? "",
                // Data detail diambil dari relasi laporan di API (jika ada)
                nama: item['laporan']?['nama'], 
                email: item['laporan']?['email'],
                deskripsi: item['laporan']?['deskripsi'],
                tanggal: item['laporan']?['date'],
                statusLaporan: item['laporan']?['status'] ?? "Pending",
                hasDetail: item['laporan'] != null, // Otomatis true jika ada data laporan
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String message;
  final String time;
  final String? nama;
  final String? email;
  final String? deskripsi;
  final String? tanggal;
  final String? statusLaporan;
  final bool hasDetail;

  const NotificationCard({
    super.key,
    required this.title,
    required this.message,
    required this.time,
    this.nama,
    this.email,
    this.deskripsi,
    this.tanggal,
    this.statusLaporan,
    this.hasDetail = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black)),
          const SizedBox(height: 4),
          Text(message, style: const TextStyle(color: Colors.black87, fontSize: 14)),
          
          if (hasDetail) ...[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Detail Laporan:", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  const SizedBox(height: 4),
                  _detailText("Nama: ${nama ?? '-'}"),
                  _detailText("Email: ${email ?? '-'}"),
                  _detailText("Deskripsi: ${deskripsi ?? '-'}"),
                  _detailText("Tanggal: ${tanggal ?? '-'}"),
                  _detailText("Status: ${statusLaporan ?? 'Pending'}"),
                ],
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _detailText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.black87)),
    );
  }
}