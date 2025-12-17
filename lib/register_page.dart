import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A0072),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF5E2A6E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const Icon(Icons.person, size: 60, color: Colors.white),
                const SizedBox(height: 10),

                const Text(
                  'DAFTAR AKUN BARU',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                _field('Nama Lengkap', Icons.person),
                _field('Email', Icons.email),
                _password('Password'),
                _password('Ulangi Password'),

                const SizedBox(height: 20),

                _button('Daftar', () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Pendaftaran berhasil')),
                  );

                  Navigator.pushReplacementNamed(context, '/login');
                }),

                const SizedBox(height: 10),

                _button('Kembali', () {
                  Navigator.pop(context);
                }, isSecondary: true),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget _field(String hint, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.white, // ⬅️ PUTIH
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}


Widget _password(String hint) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(
      obscureText: _obscure,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white, // ⬅️ PUTIH
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}


Widget _button(String text, VoidCallback onTap,
    {bool isSecondary = false}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSecondary ? Colors.deepPurple.shade300 : const Color(0xFF8E24AA),
        foregroundColor: Colors.white, // ⬅️ WARNA TEKS
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

}
