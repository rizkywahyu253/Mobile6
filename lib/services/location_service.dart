import 'package:geolocator/geolocator.dart';

class LocationService {
  // PERMISSION
  static Future<bool> requestPermission() async {
    LocationPermission perm = await Geolocator.checkPermission();

    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
    }

    return perm == LocationPermission.whileInUse ||
           perm == LocationPermission.always;
  }

  // GPS LOCATION (Akurasi Tinggi)
  static Future<Position> getGPSLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best, // GPS
    );
  }

  // NETWORK LOCATION (Akurasi Rendah)
  static Future<Position> getNetworkLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low, // Network Provider
    );
  }

  // STREAM LOKASI (LIVE)
  static Stream<Position> getLiveLocation() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.best,
        distanceFilter: 5,
      ),
    );
  }
}
