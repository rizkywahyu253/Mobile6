import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';

// Inisialisasi logger global
final Logger logger = Logger();

void main() {
  runApp(const VapelurrrApp());
}

class VapelurrrApp extends StatelessWidget {
  const VapelurrrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VAPELURRR Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(bodyColor: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      home: const VapeHomePage(),
    );
  }
}

class VapeHomePage extends StatefulWidget {
  const VapeHomePage({super.key});

  @override
  State<VapeHomePage> createState() => _VapeHomePageState();
}

class _VapeHomePageState extends State<VapeHomePage> {
  late Future<List<dynamic>> vapeData;

  Future<List<dynamic>> fetchVapeData() async {
    const apiUrl = 'https://fakestoreapi.com/products';
    try {
      logger.i('🔄 Mengambil data produk dari API...');
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        logger.i('✅ Data berhasil diambil (${data.length} item)');
        return data;
      } else {
        logger.e('❌ Gagal memuat data (status: ${response.statusCode})');
        throw Exception('Gagal memuat data: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      logger.e('⚠️ Kesalahan jaringan', error: e, stackTrace: stackTrace);
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    vapeData = fetchVapeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🌀 VAPELURRR Store')),
      body: FutureBuilder<List<dynamic>>(
        future: vapeData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                '❌ Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.redAccent),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('🚫 Tidak ada produk ditemukan.'));
          }

          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final item = products[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VapeDetailPage(product: item),
                    ),
                  );
                },
                child: Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Gambar dari Unsplash berdasarkan kategori
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                        child: Image.network(
                          'https://source.unsplash.com/800x600/?vape,${item['category']}',
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              item['description'],
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '💲${item['price']}',
                              style: const TextStyle(
                                color: Colors.greenAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class VapeDetailPage extends StatelessWidget {
  final dynamic product;

  const VapeDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(product['title'], maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: ListView(
        children: [
          Image.network(
            'https://source.unsplash.com/1000x800/?vape,${product['category']}',
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
                const SizedBox(height: 10),
                Text(
                  product['description'],
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 20),
                Text(
                  '💲${product['price']}',
                  style: const TextStyle(color: Colors.greenAccent, fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
