import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../models/favorite_model.dart';
import '../providers/favorites_provider.dart';
import '../services/supabase_service.dart';

class DetailPage extends StatelessWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favProv = Provider.of<FavoritesProvider>(context);
    final user = SupabaseService().currentUser;

    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Image.network(product.imageUrl, height: 250, fit: BoxFit.cover),
          const SizedBox(height: 20),

          Text(product.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          Text(product.description),
          const SizedBox(height: 20),

          Text("Harga: \$${product.price}",
              style: const TextStyle(fontSize: 18)),

          const SizedBox(height: 30),

          ElevatedButton.icon(
            onPressed: () async {
              if (user == null) return;

              await favProv.addFavorite(FavoriteModel(
                id: 0,
                userId: user.id,
                productId: product.id,
                title: product.title,
                price: product.price,
                imageUrl: product.imageUrl,
                createdAt: DateTime.now(),
              ));

              if (context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Ditambahkan ke Favorites")));
              }
            },
            icon: const Icon(Icons.favorite_border),
            label: const Text("Tambah ke Favorite"),
          ),
        ],
      ),
    );
  }
}