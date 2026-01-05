import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product_provider.dart';
import '../providers/user_provider.dart';
import '../app_routes.dart';
import '../widgets/product_card.dart';

// Import halaman lokasi
import '../page/network_location_page.dart';
import '../page/gps_location_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final TextEditingController _searchController = TextEditingController();
  String _keyword = "";

  @override
  void initState() {
    super.initState();

    
    Provider.of<ProductProvider>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProv = Provider.of<ProductProvider>(context);
    final userProv = Provider.of<UserProvider>(context);

    final filteredProducts = productProv.products
        .where((product) =>
            product.category
                .toLowerCase()
                .contains(_keyword.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 218, 189, 6),
        elevation: 3,
        shadowColor: const Color.fromARGB(193, 201, 200, 194),
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Text(
              "Halo, ${userProv.user?.username ?? '-'}",
              style: const TextStyle(
                color: Color.fromARGB(221, 11, 11, 11),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.map);
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.redAccent),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.favorites);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.black),
            onPressed: () async {
              await userProv.logout();
              if (mounted) {
                Navigator.pushReplacementNamed(
                  context,
                  AppRoutes.login,
                );
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: productProv.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  const Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD700),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const NetworkLocationPage(),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.grey.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.wifi_tethering,
                                    color: Colors.blue,
                                    size: 28,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "Network Location\n(Lacak via Provider)",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const GPSLocationPage(),
                              ),
                            );
                          },
                          child: Card(
                            color: Colors.grey.shade900,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.gps_fixed,
                                    color: Colors.green,
                                    size: 28,
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      "GPS Location\n(Lacak via GPS)",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  
                  const Text(
                    "Produk Terbaru",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFD700),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        _keyword = value;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Cari produk...",
                      hintStyle:
                          const TextStyle(color: Colors.white54),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      suffixIcon: _keyword.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {
                                  _keyword = "";
                                });
                              },
                            )
                          : null,
                    ),
                  ),

                  const SizedBox(height: 10),

                  
                  Expanded(
                    child: ListView.builder(
                      physics:
                          const BouncingScrollPhysics(),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        return AnimatedOpacity(
                          opacity: 1,
                          duration: Duration(
                            milliseconds:
                                200 + (index * 80),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 12),
                            child: ProductCard(
                              product:
                                  filteredProducts[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
