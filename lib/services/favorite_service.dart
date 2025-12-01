import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class FavoritesService {
  final SupabaseClient client = SupabaseService().client;

  // Insert favorite
  Future<void> addFavorite({
    required String userId,
    required int productId,
    required String title,
    required double price,
    required String imageUrl,
  }) async {
    await client.from('favorites').insert({
      'user_id': userId,
      'product_id': productId,
      'title': title,
      'price': price,
      'image_url': imageUrl,
    });
  }

  // Get user's favorites
  Future<List<Map<String, dynamic>>> getFavorites(String userId) async {
    return await client
        .from('favorites')
        .select()
        .eq('user_id', userId);
  }

  // Delete
  Future<void> deleteFavorite(int id) async {
    await client.from('favorites').delete().eq('id', id);
  }
}