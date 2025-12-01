import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProvider extends ChangeNotifier {
  final SupabaseService supabase = SupabaseService();
  UserModel? user;
  bool isLoading = false;

  // ===================== REGISTER =====================
  Future<String?> register(String email, String password, String username) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await supabase.signUp(email, password, username);
      final newUser = response.user;

      if (newUser == null) {
        throw Exception("Gagal register. Pastikan email belum digunakan.");
      }

      final uid = newUser.id;

      // Insert ke tabel profiles (opsional)
      await supabase.client.from('profiles').insert({
        'id': uid,
        'username': username,
      });

      // Insert ke tabel users
      await supabase.client.from('users').insert({
        'id': uid,
        'name': username,
        'avatar_url': "https://source.unsplash.com/300x300/?avatar",
        'created_at': DateTime.now().toIso8601String(),
      });

      // Ambil profile
      await fetchUserProfile();

      isLoading = false;
      notifyListeners();
      return null; // sukses
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return e.toString(); // kembalikan error
    }
  }

  // ===================== LOGIN =====================
  Future<String?> login(String email, String password) async {
    try {
      isLoading = true;
      notifyListeners();

      final response = await supabase.signIn(email, password);
      final loggedInUser = response.user;

      if (loggedInUser == null) {
        throw Exception("Email atau password salah");
      }

      await fetchUserProfile();

      isLoading = false;
      notifyListeners();
      return null; // sukses
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return e.toString();
    }
  }

  // ===================== FETCH PROFILE =====================
  Future<void> fetchUserProfile() async {
    final uid = supabase.currentUser?.id;
    if (uid == null) return;

    try {
      final data = await supabase.client
          .from('profiles')
          .select()
          .eq('id', uid)
          .single();

      user = UserModel.fromMap(data);
      notifyListeners();
    } catch (e) {
      print("FETCH PROFILE ERROR: $e");
    }
  }

  // ===================== LOGOUT =====================
  Future<void> logout() async {
    try {
      await supabase.signOut();
      user = null;
      notifyListeners();
    } catch (e) {
      print("LOGOUT ERROR: $e");
    }
  }
}
