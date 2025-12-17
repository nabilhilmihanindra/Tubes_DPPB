import 'package:flutter/material.dart';

class TinjauanPage extends StatefulWidget {
  const TinjauanPage({super.key});

  @override
  State<TinjauanPage> createState() => _TinjauanPageState();
}

class _TinjauanPageState extends State<TinjauanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A0072),
      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            TinjauanCard(judul: 'Polsek Kemuning'),
            SizedBox(height: 20),
            TinjauanCard(judul: 'Polsek Jakabaring'),
            SizedBox(height: 20),
            TinjauanCard(judul: 'Polsek Ilir Barat'),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// ================= CARD TINJAUAN ======================
// ======================================================

class TinjauanCard extends StatefulWidget {
  final String judul;
  const TinjauanCard({super.key, required this.judul});

  @override
  State<TinjauanCard> createState() => _TinjauanCardState();
}

class _TinjauanCardState extends State<TinjauanCard> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telpController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _telpController.dispose();
    _deskripsiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF5E2A6E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= JUDUL =================
          Center(
            child: Text(
              widget.judul,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 16),

          _inputField('Nama', _namaController),
          _inputField('Email', _emailController),
          _inputField('No telepon', _telpController),
          _inputField(
            'Deskripsi masukan',
            _deskripsiController,
            maxLines: 4,
          ),

          const SizedBox(height: 12),

          // ================= BUTTON =================
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8E24AA),
                     foregroundColor: Colors.white, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Masukan ke ${widget.judul} terkirim'),
                      ),
                    );
                  },
                  child: const Text('Kirim'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade300,
                     foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    _namaController.clear();
                    _emailController.clear();
                    _telpController.clear();
                    _deskripsiController.clear();
                  },
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= INPUT FIELD =================
  Widget _inputField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white),
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white30),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
