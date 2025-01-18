// lib/src/screens/trajectory_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/trajectory.dart';
import '../widgets/trajectory_list.dart';
import '../widgets/custom_app_bar.dart';
import '../services/location_service.dart';
import 'FeedbackScreen.dart';

class TrajectoryScreen extends StatefulWidget {
  const TrajectoryScreen({super.key});

  @override
  State<TrajectoryScreen> createState() => _TrajectoryScreenState();
}

class _TrajectoryScreenState extends State<TrajectoryScreen> {
  final List<Trajectory> trajectories = [
    Trajectory(
      name: "Sidi Moumen - Hay Al Falah",
      price: "5 DH",
      duration: "30 min",
      points: [
        LatLng(33.588252, -7.499651), // Point de départ
        LatLng(33.576203, -7.517864),
        LatLng(33.572761, -7.530682),
        LatLng(33.569256, -7.533057),
        LatLng(33.568083, -7.538565),
        LatLng(33.560861, -7.551575), // Point d'arrivée
      ],
    ),
    Trajectory(
      name: "Hay Al Falah - Ain Chock",
      price: "10 DH",
      duration: "45 min",
      points: [
        LatLng(33.560819, -7.551719), // Point de départ
        LatLng(33.543552, -7.581113),
        LatLng(33.554340, -7.592170),
        LatLng(33.550220, -7.599271),
        LatLng(33.548234, -7.599810),
        LatLng(33.548543, -7.602264), // Point d'arrivée
      ],
    ),
  ];

  int? selectedIndex;
  late GoogleMapController mapController;
  final LocationService locationService = LocationService();

  void _toggleTrajectorySelection(int index) {
    setState(() {
      if (selectedIndex == index) {
        selectedIndex = null;
      } else {
        selectedIndex = index;
      }
    });
  }

  Set<Marker> _getAllStationsMarkers() {
    Set<Marker> markers = {};

    for (var trajectory in trajectories) {
      final startPoint = trajectory.points.first;
      final endPoint = trajectory.points.last;

      markers.add(
        Marker(
          markerId: MarkerId('start_${trajectory.name}'),
          position: startPoint,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: 'Départ: ${trajectory.name}'),
        ),
      );

      markers.add(
        Marker(
          markerId: MarkerId('end_${trajectory.name}'),
          position: endPoint,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: InfoWindow(title: 'Arrivée: ${trajectory.name}'),
        ),
      );
    }

    return markers;
  }

  void _centerMapOnUserLocation() async {
    final userLocation = await locationService.getCurrentLocation();
    mapController.animateCamera(
      CameraUpdate.newLatLngZoom(userLocation, 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Trajectoires'),
      body: Column(
        children: [
          Expanded(
            flex: 2, // Donne plus d'espace à la carte
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(33.562688, -7.594326),
                zoom: 12,
              ),
              polylines: selectedIndex != null
                  ? {
                      Polyline(
                        polylineId: const PolylineId('trajectory'),
                        points: trajectories[selectedIndex!].points,
                        color: Colors.blue,
                        width: 5,
                      )
                    }
                  : {},
              markers: _getAllStationsMarkers(),
              onMapCreated: (controller) {
                mapController = controller;
              },
            ),
          ),
          Expanded(
            flex: 1, // Donne moins d'espace à la liste
            child: TrajectoryList(
              trajectories: trajectories,
              selectedIndex: selectedIndex,
              onSelectionChanged: _toggleTrajectorySelection,
            ),
          ),
        ],
      ),
      // lib/src/screens/trajectory_screen.dart
floatingActionButton: Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    FloatingActionButton(
      onPressed: _centerMapOnUserLocation,
      child: const Icon(Icons.my_location),
      backgroundColor: Colors.blue,
    ),
    const SizedBox(height: 16),
    // Supprimez le widget Hero ici si vous l'utilisez autour du FloatingActionButton
    FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeedbackScreen()),
        );
      },
      child: const Icon(Icons.feedback),
      backgroundColor: Colors.green,
    ),
  ],
),
    );
  }
}