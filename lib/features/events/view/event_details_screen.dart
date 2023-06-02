import 'package:flutter/material.dart';
import 'package:chip_in/features/events/models/event_model.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  EventDetailsScreen({required this.event});

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Date: ${widget.event.dateTime}'),
            Text('Location: ${widget.event.location}'),
            Text('Description: ${widget.event.description}'),
            // Add other event details here
            // ...
            Visibility(
              visible: widget.event.creatorId == widget.event.creatorId,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text('Edit'),
                    onPressed: () {
                      // Handle event editing here
                    },
                  ),
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      // Handle event deletion here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
