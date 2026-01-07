import 'package:flutter/material.dart';
import 'package:tubes/views/home/home_content.dart';
import 'home_content.dart';
import '../lapor/lapor_page.dart';
import '../lapor/tinjauan_page.dart';
import '../notif_page.dart';
import '../auth/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeContent(),
    LaporPage(),
    TinjauanPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: const Text(
    'Sahabat Warga',
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: const Color(0xFF5B136E),
        actions: [
          // NOTIF ATAS
          IconButton(
            icon: const Icon(Icons.notifications,color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotifPage()),
              );
            },
          ),

          // LOGIN / REGISTER
          IconButton(
            icon: const Icon(Icons.login, color: Colors.white),          
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
              );
            },
          ),
        ],
      ),

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF5B136E),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.edit), label: 'Lapor'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Feedback'),
        ],
      ),
    );
  }
}
