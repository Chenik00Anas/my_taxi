// lib/src/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'trajectory_screen.dart'; // Assurez-vous que le chemin est correct

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Délai de 2 secondes avant de naviguer vers l'écran principal
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TrajectoryScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Couleur de fond du Splash Screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.directions_bus, // Icône du Splash Screen
              size: 100,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            Text(
              'my taxi', // Texte du Splash Screen
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}