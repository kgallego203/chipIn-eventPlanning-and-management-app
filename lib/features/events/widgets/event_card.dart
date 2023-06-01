import 'package:flutter/material.dart';
import 'package:chip_in/features/events/models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              event.dateTime.toString(), // You might want to format this date
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              event.location,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              event.description,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
