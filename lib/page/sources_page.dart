import 'package:flutter/material.dart';

class SourcesPage extends StatelessWidget {
  const SourcesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sources / Credits'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SOURCE & API",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text("- Product API: fakestoreapi.com"),
            Text("- Auth & Database: Supabase"),
            SizedBox(height: 16),

            Text(
              "DEVELOPER",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text("Nama: (Isikan nama kamu di sini!)"),
            Text("Project Mobile Flutter"),
          ],
        ),
      ),
    );
  }
}