import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseClient get client => Supabase.instance.client;

  // Singleton
  static final SupabaseService _instance = SupabaseService._internal();
  SupabaseService._internal();
  factory SupabaseService() => _instance;

  // ===================== REGISTER =====================
  Future<AuthResponse> signUp(String email, String password, String username) async {
    return await client.auth.signUp(
      email: email,
      password: password,
      phone: AuthOptions(
        data: {'username': username}, // metadata
      ),
    );
  }

  // ===================== LOGIN =====================
  Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // ===================== LOGOUT =====================
  Future<void> signOut() async {
    await client.auth.signOut();
  }

  // ===================== CURRENT USER =====================
  User? get currentUser => client.auth.currentUser;
  
  AuthOptions({required Map<String, String> data}) {}
}
