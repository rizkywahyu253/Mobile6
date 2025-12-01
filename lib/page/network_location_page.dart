import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/map_widget.dart';

class NetworkLocationPage extends StatefulWidget {
  const NetworkLocationPage({super.key});

  @override
  State<NetworkLocationPage> createState() => _NetworkLocationPageState();
}

class _NetworkLocationPageState extends State<NetworkLocationPage> {
  double lat = 0;
  double lng = 0;
  double accuracy = 0;

  @override
  void initState() {
    super.initState();
    _loadNetworkLocation();
  }

  Future<void> _loadNetworkLocation() async {
    final pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
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
      appBar: AppBar(title: const Text("Network Location")),
      body: Column(
        children: [
          ListTile(title: const Text("Latitude"), subtitle: Text("$lat")),
          ListTile(title: const Text("Longitude"), subtitle: Text("$lng")),
          ListTile(title: const Text("Akurasi"), subtitle: Text("$accuracy m")),

          Expanded(
            child: MapWidget(
              lat: lat,
              lng: lng,
              color: Colors.blue, // warna marker
            ),
          ),
        ],
      ),
    );
  }
}
