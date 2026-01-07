import 'package:flutter/material.dart';
import '../../services/feedback_service.dart';

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            TinjauanCard(judul: 'Feedback'),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class TinjauanCard extends StatefulWidget {
  final String judul;
  const TinjauanCard({super.key, required this.judul});

  @override
  State<TinjauanCard> createState() => _TinjauanCardState();
}

class _TinjauanCardState extends State<TinjauanCard> {
  // Controller yang sudah dipisah sesuai fungsinya
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telpController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  
  bool _isSending = false;

  void _handleKirim() async {
    if (_deskripsiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Deskripsi masukan tidak boleh kosong')),
      );
      return;
    }

    setState(() => _isSending = true);

    bool success = await FeedbackService().kirimFeedback(
      nama: _namaController.text,
      email: _emailController.text,
      notelp: _telpController.text,
      deskripsi: _deskripsiController.text,
    );

    setState(() => _isSending = false);

    if (success) {
      _namaController.clear();
      _emailController.clear();
      _telpController.clear();
      _deskripsiController.clear();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukan ke ${widget.judul} terkirim!')),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengirim. Pastikan Anda sudah login.')),
      );
    }
  }

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
          _inputField('No telp', _telpController),
          _inputField('Deskripsi masukan', _deskripsiController, maxLines: 4),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E24AA),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: _isSending ? null : _handleKirim,
              child: _isSending 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                : const Text('Kirim'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.white70),
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white24),
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