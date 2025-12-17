import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A0072),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(Icons.account_circle,
                    size: 50, color: Color(0xFF4A0072)),
              ),
              const SizedBox(height: 20),

              const Text(
                'Masukkan Email',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              _input('Email', Icons.email),

              const SizedBox(height: 20),

              const Text(
                'Masukkan Password',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),
              _password(),

              const SizedBox(height: 24),

              Row(
                children: [
                  Expanded(
                    child: _button('Daftar', () {
                      Navigator.pushNamed(context, '/register');

                    }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _button('Login', () {
                      Navigator.pushReplacementNamed(context, '/home');
                    }),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              const Text(
                'www.sahabatwarga.com',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input(String hint, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _password() {
    return TextField(
      obscureText: _obscure,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

Widget _button(String text, VoidCallback onTap) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF8E24AA),
      foregroundColor: Colors.white, // ⬅️ WARNA TEKS
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    onPressed: onTap,
    child: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
  );
}

}
