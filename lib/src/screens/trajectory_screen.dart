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
    Trajectory(
    name: "سوق الجملة للخضر و الفواكه - قاعة الحفلات الغابة الخضراء",
    price: "6 DH",
    duration: "35 min",
    points: [
      LatLng(33.55458683224731, -7.563267739983627),
      LatLng(33.556125, -7.559938),
      LatLng(33.563598, -7.547157),
      LatLng(33.566399, -7.542272),
      LatLng(33.568040, -7.538253),
      LatLng(33.5680320398665, -7.534849077858819),
    ],
  ),
  Trajectory(
    name: "قاعة الحفلات الغابة الخضراء - مسجد الأندلس، الدارالبيضاء أناسي.",
    price: "7 DH",
    duration: "40 min",
    points: [
      LatLng(33.5680320398665, -7.534849077858819),
      LatLng(33.569152, -7.533020),
      LatLng(33.570973, -7.531428),
      LatLng(33.572887, -7.530611),
      LatLng(33.576455, -7.518235),
      LatLng(33.589039746953816, -7.496119756009406),
    ],
  ),
  Trajectory(
    name: "Aïn Sebaâ - Derb Sultan",
    price: "8 DH",
    duration: "50 min",
    points: [
      LatLng(33.613056, -7.585351),
      LatLng(33.600871, -7.578456),
      LatLng(33.588019, -7.574230),
      LatLng(33.572156, -7.591799),
    ],
  ),
  Trajectory(
    name: "Sidi Bernoussi - Hay Mohammadi",
    price: "6 DH",
    duration: "35 min",
    points: [
      LatLng(33.613900, -7.509300),
      LatLng(33.605300, -7.524500),
      LatLng(33.595800, -7.539400),
      LatLng(33.584200, -7.545700),
    ],
  ),
  Trajectory(
    name: "Hay El Falah - Aïn Diab",
    price: "10 DH",
    duration: "45 min",
    points: [
      LatLng(33.560861, -7.551575),
      LatLng(33.566112, -7.580738),
      LatLng(33.574681, -7.616088),
      LatLng(33.582481, -7.648178),
    ],
  ),
  Trajectory(
    name: "Sidi Othmane - Derb Ghallef",
    price: "7 DH",
    duration: "30 min",
    points: [
      LatLng(33.586910, -7.529205),
      LatLng(33.574321, -7.547292),
      LatLng(33.566230, -7.564812),
      LatLng(33.567220, -7.591481),
    ],
  ),
  Trajectory(
    name: "Aïn Chock - Maârif",
    price: "8 DH",
    duration: "40 min",
    points: [
      LatLng(33.567589, -7.620181),
      LatLng(33.574889, -7.602114),
      LatLng(33.579010, -7.585012),
      LatLng(33.587715, -7.580180),
    ],
  ),
  Trajectory(
    name: "Oulfa - Aïn Diab",
    price: "9 DH",
    duration: "50 min",
    points: [
      LatLng(33.557980, -7.663171),
      LatLng(33.565200, -7.642200),
      LatLng(33.576015, -7.638315),
      LatLng(33.581520, -7.640720),
      LatLng(33.584515, -7.647820),
    ],
  ),
  Trajectory(
    name: "Sidi Moumen - Derb Sultan",
    price: "6 DH",
    duration: "40 min",
    points: [
      LatLng(33.588252, -7.499651),
      LatLng(33.580121, -7.511010),
      LatLng(33.574891, -7.526201),
      LatLng(33.569842, -7.542761),
      LatLng(33.562888, -7.572701),
    ],
  ),
  Trajectory(
    name: "Hay Mohammadi - Aïn Chock",
    price: "7 DH",
    duration: "45 min",
    points: [
      LatLng(33.585201, -7.558092),
      LatLng(33.574021, -7.576092),
      LatLng(33.565091, -7.590011),
      LatLng(33.558220, -7.614471),
    ],
  ),
  Trajectory(
  name: "Hay Hassani - Sidi Maarouf",
  price: "7 DH",
  duration: "35 min",
  points: [
    LatLng(33.552000, -7.665900),
    LatLng(33.550200, -7.650900),
    LatLng(33.547400, -7.635000),
    LatLng(33.542600, -7.620000),
  ],
),
Trajectory(
  name: "Derb Sultan - Aïn Diab",
  price: "8 DH",
  duration: "40 min",
  points: [
    LatLng(33.567300, -7.574000),
    LatLng(33.573000, -7.590000),
    LatLng(33.580000, -7.610000),
    LatLng(33.583200, -7.638000),
  ],
),
Trajectory(
  name: "Hay Mohammadi - Bourgogne",
  price: "7 DH",
  duration: "30 min",
  points: [
    LatLng(33.588800, -7.543600),
    LatLng(33.590700, -7.564900),
    LatLng(33.591900, -7.582100),
    LatLng(33.592900, -7.610300),
  ],
),
Trajectory(
  name: "Sidi Bernoussi - Aïn Chock",
  price: "9 DH",
  duration: "50 min",
  points: [
    LatLng(33.612700, -7.507900),
    LatLng(33.598000, -7.540000),
    LatLng(33.580000, -7.580000),
    LatLng(33.565000, -7.620000),
  ],
),
Trajectory(
  name: "Maarif - Hay El Falah",
  price: "6 DH",
  duration: "35 min",
  points: [
    LatLng(33.584300, -7.623000),
    LatLng(33.570000, -7.600000),
    LatLng(33.564200, -7.575000),
    LatLng(33.560800, -7.552000),
  ],
),
Trajectory(
  name: "Oasis - Sbata",
  price: "7 DH",
  duration: "35 min",
  points: [
    LatLng(33.565600, -7.622500),
    LatLng(33.558700, -7.610000),
    LatLng(33.552100, -7.592000),
    LatLng(33.546300, -7.571000),
  ],
),
Trajectory(
  name: "Ben M'Sick - Derb Omar",
  price: "7 DH",
  duration: "30 min",
  points: [
    LatLng(33.566000, -7.531000),
    LatLng(33.571000, -7.550000),
    LatLng(33.578000, -7.570000),
    LatLng(33.586000, -7.593000),
  ],
),
Trajectory(
  name: "Oulfa - Mers Sultan",
  price: "8 DH",
  duration: "45 min",
  points: [
    LatLng(33.557000, -7.665000),
    LatLng(33.564000, -7.640000),
    LatLng(33.570000, -7.615000),
    LatLng(33.573500, -7.590000),
  ],
),
Trajectory(
  name: "Hay Salam - El Hank",
  price: "9 DH",
  duration: "50 min",
  points: [
    LatLng(33.546000, -7.520000),
    LatLng(33.560000, -7.545000),
    LatLng(33.576000, -7.580000),
    LatLng(33.591000, -7.642000),
  ],
),
Trajectory(
  name: "Sidi Moumen - Casa-Port",
  price: "10 DH",
  duration: "55 min",
  points: [
    LatLng(33.588300, -7.499700),
    LatLng(33.580000, -7.520000),
    LatLng(33.580500, -7.548000),
    LatLng(33.590500, -7.600000),
    LatLng(33.596500, -7.615500),
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
        _zoomOnTrajectory(trajectories[index]);
      }
    });
  }

  void _zoomOnTrajectory(Trajectory trajectory) {
    // Calculer les limites du trajet
    LatLngBounds bounds = _calculateBounds(trajectory.points);

    // Animer la caméra pour zoomer sur le trajet
    mapController.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 50), // 50 est la marge en pixels
    );
  }

  LatLngBounds _calculateBounds(List<LatLng> points) {
    double? minLat, maxLat, minLng, maxLng;

    for (var point in points) {
      if (minLat == null || point.latitude < minLat) {
        minLat = point.latitude;
      }
      if (maxLat == null || point.latitude > maxLat) {
        maxLat = point.latitude;
      }
      if (minLng == null || point.longitude < minLng) {
        minLng = point.longitude;
      }
      if (maxLng == null || point.longitude > maxLng) {
        maxLng = point.longitude;
      }
    }

    return LatLngBounds(
      northeast: LatLng(maxLat!, maxLng!),
      southwest: LatLng(minLat!, minLng!),
    );
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
    try {
      final userLocation = await locationService.getCurrentLocation();
      mapController.animateCamera(
        CameraUpdate.newLatLngZoom(userLocation, 14),
      );
    } catch (e) {
      // Gérer les erreurs (par exemple, permissions, services de localisation désactivés)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Trajectoires'),
      body: Column(
        children: [
          Expanded(
            flex: 2,
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
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: TrajectoryList(
                trajectories: trajectories,
                selectedIndex: selectedIndex,
                onSelectionChanged: _toggleTrajectorySelection,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _centerMapOnUserLocation,
            child: const Icon(Icons.my_location),
            backgroundColor: Colors.blue,
          ),
          const SizedBox(height: 16),
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