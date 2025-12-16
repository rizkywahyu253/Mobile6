import 'dart:io'; // <-- TAMBAHKAN INI

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // ✅ TAMBAHAN WAJIB
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/notification_handler.dart';

import 'app_routes.dart';
import 'theme.dart';
import 'providers/user_provider.dart';
import 'providers/product_provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/location_provider.dart';

// === UNTUK FIX TILE MAP YANG TIDAK MUNCUL ===
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ TAMBAHAN WAJIB (TIDAK MENGUBAH ALUR)
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  await Get.putAsync(() async => await SharedPreferences.getInstance());
  await FirebaseMessagingHandler().initPushNotification();
  await FirebaseMessagingHandler().initLocalNotification();

  // Tambahkan ini sebelum Supabase dan runApp
  HttpOverrides.global = MyHttpOverrides();

  await Supabase.initialize(
    url: "https://wieklovaspyelpuptzmc.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndpZWtsb3Zhc3B5ZWxwdXB0em1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM5MDkyOTAsImV4cCI6MjA3OTQ4NTI5MH0.u1LQzwfRwZikZtA6lO3pGo1rSFZk2q8kCnbfHp029eM",
  );

  runApp(const VapeApp());
}

class VapeApp extends StatelessWidget {
  const VapeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Vapelurr Store",
        theme: AppTheme.lightTheme,
        routes: AppRoutes.routes,
        initialRoute: AppRoutes.login,
      ),
    );
  }
}
