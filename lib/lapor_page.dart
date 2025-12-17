import 'package:flutter/material.dart';

class LaporPage extends StatefulWidget {
  const LaporPage({super.key});

  @override
  State<LaporPage> createState() => _LaporPageState();
}

class _LaporPageState extends State<LaporPage> {
  final List<Map<String, String>> _riwayat = [
    {
      'judul': 'Pencurian Motor',
      'status': 'Diproses',
    },
    {
      'judul': 'Lampu Jalan Mati',
      'status': 'Selesai',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A0072),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            const Text(
              '+ Buat Laporan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            _input(Icons.person, 'Nama'),
            _input(Icons.email, 'Email'),
            _input(Icons.phone, '+62'),
            _input(Icons.calendar_today, 'mm/dd/yyyy'),
            _input(Icons.access_time, '--:--'),

            _fileUpload(),

            _description(),

            const SizedBox(height: 15),

            _submitButton(),

            const SizedBox(height: 30),

            const Text(
              'Riwayat Laporan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            ..._riwayat.map((lapor) => _riwayatCard(lapor)).toList(),
          ],
        ),
      ),
    );
  }

  // ================= INPUT =================
  Widget _input(IconData icon, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  // ================= FILE UPLOAD (DUMMY) =================
  Widget _fileUpload() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: const [
          Icon(Icons.attach_file),
          SizedBox(width: 10),
          Text('Choose file    No file chosen'),
        ],
      ),
    );
  }

  // ================= DESKRIPSI =================
  Widget _description() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Deskripsi kejadian',
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }

  // ================= BUTTON =================
  Widget _submitButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9C27B0),
           foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          setState(() {
            _riwayat.insert(0, {
              'judul': 'Laporan Baru',
              'status': 'Diterima',
            });
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Laporan berhasil dikirim')),
          );
        },
        child: const Text('Kirim laporan'),
      ),
    );
  }

  // ================= RIWAYAT CARD =================
  Widget _riwayatCard(Map<String, String> data) {
    Color statusColor;

    switch (data['status']) {
      case 'Selesai':
        statusColor = Colors.green;
        break;
      case 'Diproses':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.blue;
    }

    return Card(
      child: ListTile(
        title: Text(data['judul']!),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            data['status']!,
            style: TextStyle(color: statusColor),
          ),
        ),
      ),
    );
  }
}
