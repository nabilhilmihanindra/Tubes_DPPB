import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../services/lapor_service.dart';

class LaporPage extends StatefulWidget {
  const LaporPage({super.key});

  @override
  State<LaporPage> createState() => _LaporPageState();
}

class _LaporPageState extends State<LaporPage> {
  String? _selectedPolres;
  String _fileName = 'No file chosen';
  String? _filePath;
  bool _isUploading = false;

  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _telpController = TextEditingController();
  final TextEditingController _tglController = TextEditingController();
  final TextEditingController _jamController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  final List<String> _listPolres = [
    'Polres Palembang',
    'Polres Banyuasin',
    'Polres Ogan Ilir',
    'Polres Muara Enim',
  ];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _filePath = result.files.single.path;
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (_deskripsiController.text.isEmpty || _selectedPolres == null || _alamatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi data!'))
      );
      return;
    }

    setState(() => _isUploading = true);

    bool success = await LaporService().kirimLaporan(
      alamat: _alamatController.text,
      polres: _selectedPolres!,
      telp: _telpController.text,
      tanggal: _tglController.text,
      jam: _jamController.text,
      deskripsi: _deskripsiController.text,
      filePath: _filePath,
    );

    setState(() => _isUploading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Laporan Berhasil Terkirim!'))
      );
      
      // Clear Form
      _alamatController.clear();
      _telpController.clear();
      _tglController.clear();
      _jamController.clear();
      _deskripsiController.clear();
      
      setState(() {
        _selectedPolres = null;
        _fileName = 'No file chosen';
        _filePath = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengirim ke server.'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A0072),
      body: RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Buat Laporan', 
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 16),
              
              _input(Icons.map, 'Alamat lengkap...', _alamatController),
              _dropdown(),
              _input(Icons.phone, 'No Telepon', _telpController),
              _input(Icons.calendar_today, 'DD-MM-YYYY', _tglController),
              _input(Icons.access_time, '--:--', _jamController),
              _fileUpload(),
              _description(),
              
              const SizedBox(height: 15),
              _submitButton(),
              const SizedBox(height: 30),
              
              const Text(
                'Riwayat Laporan', 
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
              ),
              const SizedBox(height: 10),
              
              FutureBuilder<List<dynamic>>(
                future: LaporService().getRiwayatLaporan(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white));
                  }
                  
                  final riwayat = snapshot.data ?? [];
                  if (riwayat.isEmpty) {
                    return const Text("Belum ada riwayat", style: TextStyle(color: Colors.white70));
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: riwayat.length,
                    itemBuilder: (context, index) {
                      final item = riwayat[index];
                      return _riwayatCard(
                        item['deskripsi'] ?? 'Laporan Kejadian', 
                        item['status'] ?? 'Pending'
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  Widget _dropdown() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: _selectedPolres,
        dropdownColor: Colors.purple[50],
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.location_city),
          filled: true, 
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
        hint: const Text("-- Pilih Polres --"),
        items: _listPolres.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (val) => setState(() => _selectedPolres = val),
      ),
    );
  }

  Widget _input(IconData icon, String hint, TextEditingController ctrl) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: ctrl,
        decoration: InputDecoration(
          hintText: hint, 
          prefixIcon: Icon(icon),
          filled: true, 
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _fileUpload() {
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const Icon(Icons.attach_file), 
            const SizedBox(width: 10), 
            Expanded(child: Text(_fileName, overflow: TextOverflow.ellipsis))
          ]
        ),
      ),
    );
  }

  Widget _description() {
    return TextField(
      controller: _deskripsiController, 
      maxLines: 4,
      decoration: InputDecoration(
        hintText: 'Deskripsi...', 
        filled: true, 
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)
      ),
    );
  }

  Widget _submitButton() {
    return SizedBox(
      width: double.infinity, 
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF9C27B0), 
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        onPressed: _isUploading ? null : _handleSubmit,
        child: _isUploading 
          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) 
          : const Text('Kirim Laporan', style: TextStyle(fontWeight: FontWeight.bold)),
      )
    );
  }

  Widget _riwayatCard(String judul, String status) {
    Color statusColor;
    
    // Logika Warna Sesuai Permintaan
    switch (status.toLowerCase()) {
      case 'approved':
        statusColor = Colors.green; // Hijau
        break;
      case 'pending':
        statusColor = Colors.blue;  // Biru
        break;
      case 'rejected':
        statusColor = Colors.orange; // Oranye
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(judul, maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1), 
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: statusColor.withOpacity(0.5))
          ),
          child: Text(
            status, 
            style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)
          ),
        ),
      ),
    );
  }
}