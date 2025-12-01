import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<FavoritesProvider>(context, listen: false).loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final favProv = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: favProv.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: favProv.favorites.length,
              itemBuilder: (_, i) {
                final fav = favProv.favorites[i];
                return ListTile(
                  leading: Image.network(fav.imageUrl, width: 50),
                  title: Text(fav.title),
                  subtitle: Text("\$${fav.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      await favProv.removeFavorite(fav.id);
                    },
                  ),
                );
              },
            ),
    );
  }
}