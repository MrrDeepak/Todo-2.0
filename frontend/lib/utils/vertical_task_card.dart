import 'package:flutter/material.dart';

class VerticalTaskCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int tasks;
  final Color color;
  const VerticalTaskCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.tasks,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
            shadowColor: Colors.green,
            elevation: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon),
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$tasks Task',
                  style: const TextStyle(color: Colors.black),
                )
              ],
            ),
    );
  }
}
