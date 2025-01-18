import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  Future<LatLng> getCurrentLocation() async {
    // Simuler la récupération de la position de l'utilisateur
    await Future.delayed(const Duration(seconds: 1));
    return const LatLng(33.562688, -7.594326); // Exemple de position
  }
}