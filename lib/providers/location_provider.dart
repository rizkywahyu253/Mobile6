import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_save_service.dart';

class LocationProvider extends ChangeNotifier {
  Position? currentPosition;
  DateTime? lastUpdated;

  String get timeString {
    if (lastUpdated == null) return "-";
    return "${lastUpdated!.hour.toString().padLeft(2, '0')}:"
           "${lastUpdated!.minute.toString().padLeft(2, '0')}:"
           "${lastUpdated!.second.toString().padLeft(2, '0')}";
  }

  // =======================================================
  // 🚀 Load GPS (High Accuracy)
  // =======================================================
  Future<void> loadGPSLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    currentPosition = position;
    lastUpdated = DateTime.now();
    notifyListeners();

    // === SIMPAN KE SUPABASE ===
    await LocationSaveService.saveLocation(
      lat: position.latitude,
      lng: position.longitude,
      provider: "GPS",
      accuracy: position.accuracy,
    );
  }

  // =======================================================
  // 🌐 Load NETWORK (Low Accuracy)
  // =======================================================
  Future<void> loadNetworkLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
    );

    currentPosition = position;
    lastUpdated = DateTime.now();
    notifyListeners();

    // === SIMPAN KE SUPABASE ===
    await LocationSaveService.saveLocation(
      lat: position.latitude,
      lng: position.longitude,
      provider: "NETWORK",
      accuracy: position.accuracy,
    );
  }
}
