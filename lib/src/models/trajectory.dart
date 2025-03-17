import 'package:google_maps_flutter/google_maps_flutter.dart';

class Trajectory {
  final String name;
  final String price;
  final String duration;
  final List<LatLng> points;

  Trajectory({
    required this.name,
    required this.price,
    required this.duration,
    required this.points,
  });
}