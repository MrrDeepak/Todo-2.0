import 'package:flutter/material.dart';

class HorizontalTaskCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int tasks;
  final Color color;
  const HorizontalTaskCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.tasks,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: color,
      //shadowColor: Colors.amber,
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$tasks Task',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
