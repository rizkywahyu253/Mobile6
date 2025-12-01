import 'package:supabase_flutter/supabase_flutter.dart';

class LocationSaveService {
  static final supabase = Supabase.instance.client;

  static Future<void> saveLocation({
    required double lat,
    required double lng,
    required String provider,
    required double accuracy,
  }) async {
    await supabase.from('locations').insert({
      'latitude': lat,
      'longitude': lng,
      'provider': provider,
      'accuracy': accuracy,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
