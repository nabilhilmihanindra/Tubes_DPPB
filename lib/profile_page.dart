import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4A0072),
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF5B136E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ===== HEADER PROFIL =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5B136E), Color(0xFF7B1FA2)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Color(0xFF5B136E),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Nabil Hilmi',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'nabil@email.com',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ===== MENU PROFIL =====
            _profileMenu(
              icon: Icons.edit,
              text: 'Edit Profil',
              onTap: () {},
            ),
            _profileMenu(
              icon: Icons.history,
              text: 'Riwayat Laporan',
              onTap: () {},
            ),
            _profileMenu(
              icon: Icons.settings,
              text: 'Pengaturan',
              onTap: () {},
            ),
            _profileMenu(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              isLogout: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileMenu({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: isLogout ? Colors.red : const Color(0xFF5B136E),
          ),
          title: Text(
            text,
            style: TextStyle(
              color: isLogout ? Colors.red : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}
