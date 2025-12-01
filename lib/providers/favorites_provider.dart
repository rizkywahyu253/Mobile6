import 'package:flutter/material.dart';
import '../models/favorite_model.dart';
import '../services/favorite_service.dart';
import '../services/supabase_service.dart';

class FavoritesProvider extends ChangeNotifier {
  final FavoritesService service = FavoritesService();
  final SupabaseService supabase = SupabaseService();

  List<FavoriteModel> favorites = [];
  bool isLoading = false;

  Future<void> loadFavorites() async {
    try {
      isLoading = true;
      notifyListeners();

      final userId = supabase.currentUser?.id;
      if (userId == null) return;

      final data = await service.getFavorites(userId);

      favorites = data.map((e) => FavoriteModel.fromMap(e)).toList();

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite(FavoriteModel fav) async {
    await service.addFavorite(
      userId: fav.userId,
      productId: fav.productId,
      title: fav.title,
      price: fav.price,
      imageUrl: fav.imageUrl,
    );

    await loadFavorites();
  }

  Future<void> removeFavorite(int id) async {
    await service.deleteFavorite(id);
    await loadFavorites();
  }
}