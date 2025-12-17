import 'package:flutter/material.dart';

class NotifPage extends StatelessWidget {
  const NotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Laporan diterima'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Laporan sedang diproses'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Laporan selesai'),
          ),
        ],
      ),
    );
  }
}
