import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:chip_in/features/events/models/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  final MyEventModel event;

  EventDetailsScreen({required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.primary200,
        title: Text(
          widget.event.title,
          style: const TextStyle(
            color: Pallete.neutral0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${widget.event.title}',
              style: const TextStyle(
                color: Pallete.neutral120,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Date: ${widget.event.dateTime}',
              style: const TextStyle(
                color: Pallete.neutral70,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Location: ${widget.event.location}',
              style: const TextStyle(
                color: Pallete.neutral70,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Description: ${widget.event.description}',
              style: const TextStyle(
                color: Pallete.neutral70,
                fontSize: 16.0,
              ),
            ),
            // Add other event details here
            // ...
          ],
        ),
      ),
    );
  }
}
