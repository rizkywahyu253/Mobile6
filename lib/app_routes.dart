import 'package:flutter/material.dart';
import 'page/login_page.dart';
import 'page/register_page.dart';
import 'page/home_page.dart';
import 'page/favorites_page.dart';
import 'page/map_page.dart'; // <-- Tambahkan ini

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const favorites = '/favorites';
  static const map = '/map'; // <-- Tambahkan ini

  static Map<String, WidgetBuilder> routes = {
    login: (_) => LoginPage(),
    register: (_) => RegisterPage(),
    home: (_) => HomePage(),
    favorites: (_) => FavoritesPage(),
    map: (_) => MapPage(), // <-- Dan ini
  };
}
