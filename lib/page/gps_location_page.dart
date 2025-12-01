import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/map_widget.dart';

class GPSLocationPage extends StatefulWidget {
  const GPSLocationPage({super.key});

  @override
  State<GPSLocationPage> createState() => _GPSLocationPageState();
}

class _GPSLocationPageState extends State<GPSLocationPage> {
  double lat = 0;
  double lng = 0;
  double accuracy = 0;

  @override
  void initState() {
    super.initState();
    _loadGPSLocation();
  }

  Future<void> _loadGPSLocation() async {
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    setState(() {
      lat = pos.latitude;
      lng = pos.longitude;
      accuracy = pos.accuracy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("GPS Location")),
      body: Column(
        children: [
          ListTile(title: const Text("Latitude"), subtitle: Text("$lat")),
          ListTile(title: const Text("Longitude"), subtitle: Text("$lng")),
          ListTile(title: const Text("Akurasi"), subtitle: Text("$accuracy m")),

          Expanded(
            child: MapWidget(
              lat: lat,
              lng: lng,
              color: Colors.red, // warna marker GPS
            ),
          ),
        ],
      ),
    );
  }
}
