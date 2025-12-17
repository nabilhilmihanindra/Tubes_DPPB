import 'package:flutter/material.dart';

class AspirasiPage extends StatelessWidget {
  const AspirasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kotak Aspirasi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Tulis aspirasi...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Kirim'),
            )
          ],
        ),
      ),
    );
  }
}
