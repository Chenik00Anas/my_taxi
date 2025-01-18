// lib/src/widgets/trajectory_list.dart
import 'package:flutter/material.dart';
import '../models/trajectory.dart';

class TrajectoryList extends StatelessWidget {
  final List<Trajectory> trajectories;
  final int? selectedIndex;
  final ValueChanged<int> onSelectionChanged;

  const TrajectoryList({
    super.key,
    required this.trajectories,
    required this.selectedIndex,
    required this.onSelectionChanged,
  });

  // lib/src/widgets/trajectory_list.dart
@override
Widget build(BuildContext context) {
  return ListView.builder(
    shrinkWrap: true, // Permet à la ListView de s'adapter à son contenu
    physics: const NeverScrollableScrollPhysics(), // Désactive le défilement
    itemCount: trajectories.length,
    itemBuilder: (context, index) {
      final trajectory = trajectories[index];
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: const Icon(Icons.directions_bus, color: Colors.blue),
          title: Text(
            trajectory.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${trajectory.price} - ${trajectory.duration}',
            style: const TextStyle(fontSize: 14),
          ),
          selected: selectedIndex == index,
          onTap: () => onSelectionChanged(index),
          tileColor: selectedIndex == index ? Colors.blue[50] : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    },
  );
}
}