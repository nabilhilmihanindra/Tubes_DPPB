import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4A0072), Color(0xFF7B1FA2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _searchBar(),
          const SizedBox(height: 20),

          _postCard(
            imagePath: 'assets/images/pembunuhan.jpg',
            title: 'Kasus pembunuhan di wilayah Sukabangun',
          ),

          const SizedBox(height: 20),

          _postCard(
            imagePath: 'assets/images/pencurian_motor.jpg',
            title: 'Telah terekam aksi pencurian motor di Sukabangun',
          ),
        ],
      ),
    );
  }

  Widget _searchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search..',
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _postCard({
    required String imagePath,
    required String title,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/pembunuhan.jpg',
                height: 180,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                hintText: 'Tulis komentar...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Komentar:\n'
              'Budi : Anjing nyoo ooo\n'
              'Andi : Astaga ada bae gawe wong kito nih',
              style: TextStyle(fontSize: 12),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                _actionButton('Kirim', Colors.blue),
                const SizedBox(width: 8),
                _actionButton('Like', Colors.red),
                const SizedBox(width: 8),
                _actionButton('Share', Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButton(String text, Color color) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Text(text),
      ),
    );
  }
}
