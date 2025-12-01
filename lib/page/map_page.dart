import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, locationProv, child) {
        return Scaffold(
          appBar: AppBar(title: const Text("Peta Lokasi")),
          body: Stack(
            children: [
              FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: locationProv.currentPosition != null
                      ? LatLng(
                          locationProv.currentPosition!.latitude,
                          locationProv.currentPosition!.longitude,
                        )
                      : const LatLng(-6.200000, 106.816666),
                  initialZoom: 16,
                ),
                children: [
                  // === TILE LAYER ===
                  TileLayer(
                    urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),

                  // === MARKER LAYER (NO ERROR) ===
                  MarkerLayer(
                    markers: [
                      if (locationProv.currentPosition != null)
                        Marker(
                          point: LatLng(
                            locationProv.currentPosition!.latitude,
                            locationProv.currentPosition!.longitude,
                          ),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              // === BUTTONS GPS & NETWORK ===
              Positioned(
                right: 15,
                bottom: 30,
                child: Column(
                  children: [
                    FloatingActionButton(
                      heroTag: "gps",
                      backgroundColor: Colors.blue,
                      onPressed: () async {
                        await locationProv.loadGPSLocation();
                        if (locationProv.currentPosition != null) {
                          mapController.move(
                            LatLng(
                              locationProv.currentPosition!.latitude,
                              locationProv.currentPosition!.longitude,
                            ),
                            17,
                          );
                        }
                      },
                      child: const Icon(Icons.gps_fixed),
                    ),

                    const SizedBox(height: 15),

                    FloatingActionButton(
                      heroTag: "network",
                      backgroundColor: Colors.green,
                      onPressed: () async {
                        await locationProv.loadNetworkLocation();
                        if (locationProv.currentPosition != null) {
                          mapController.move(
                            LatLng(
                              locationProv.currentPosition!.latitude,
                              locationProv.currentPosition!.longitude,
                            ),
                            17,
                          );
                        }
                      },
                      child: const Icon(Icons.wifi),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
