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
            // 1. Gambar Postingan
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // 2. Judul/Deskripsi
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            
        

            // 3. BARIS LIKE (Di atas komentar & kolom input)
            Row(
              children: [
                const Spacer(), // Dorong Love ke kanan
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.favorite, color: Colors.red, size: 24),
                  onPressed: () {
                    // Logika Like Laravel
                  },
                ),
                const SizedBox(width: 4),

              ],
            ),


            // 4. DAFTAR KOMENTAR ORANG LAIN
            const Text(
              'Komentar:',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey),
            ),
            const SizedBox(height: 4),
            const Text(
              'Budi : Anjing nyoo ooo\n'
              'Andi : Astaga ada bae gawe wong kito nih',
              style: TextStyle(fontSize: 12, height: 1.5),
            ),

            const SizedBox(height: 15),

            // 5. KOLOM INPUT KOMENTAR (Paling Bawah)
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                hintText: 'Tulis komentar...',
                hintStyle: const TextStyle(fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                // Tombol Submit Biru di dalam
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue, size: 20),
                  onPressed: () {
                    // Logika Kirim Laravel
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}