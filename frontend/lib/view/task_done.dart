import 'package:flutter/material.dart';
import 'package:frontend/utils/horizontal_task_card.dart';
import 'package:frontend/utils/vertical_task_card.dart';

class TaskDone extends StatelessWidget {
  const TaskDone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final double screenWidth = MediaQuery.of(context).size.width;

    // Define responsive dimensions
    final double mobileCardWidth = screenWidth * 0.3; // 30% of screen width
    const double mobileCardHeight = 150.0; // Fixed height
    final double spacing = screenWidth * 0.03; // 3% of screen width for spacing

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: mobileCardHeight,
          width: mobileCardWidth,
          // Mobile Card
          child: const VerticalTaskCard(
            title: 'Mobile',
            icon: Icons.phone_android,
            tasks: 5,
            color: Colors.green,
          ),
        ),
        SizedBox(
          width: spacing,
        ),
        const Expanded(
          child: Column(
            children: [
              HorizontalTaskCard(
                title: 'Wireframe',
                icon: Icons.lightbulb_outline,
                tasks: 15,
                color: Colors.yellow,
              ),
              SizedBox(
                height: 8,
              ),
              HorizontalTaskCard(
                title: 'Website',
                icon: Icons.web_asset,
                tasks: 5,
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
