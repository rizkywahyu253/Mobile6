import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final double lat;
  final double lng;
  final Color color;

  const MapWidget({
    super.key,
    required this.lat,
    required this.lng,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,   // ← PENTING AGAR MAP MUNCUL !
      child: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(lat, lng),
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          ),

          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(lat, lng),
                width: 50,
                height: 50,
                child: const Icon(
                  Icons.location_pin,
                  size: 50,
                  color: Colors.amberAccent,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
