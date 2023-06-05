import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/view/event_details_screen.dart';

/// TODO: Make the event creator's first name and last name visible instead of their creator id

class EventCard extends StatelessWidget {
  final Event event; // The event object to display
  final bool
      showJoinButton; // A boolean to determine whether to show the join button or not

  const EventCard({required this.event, this.showJoinButton = true});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE, MMM d, y')
        .format(event.dateTime); // Format the date of the event
    final formattedTime = DateFormat('h:mm a')
        .format(event.dateTime); // Format the time of the event

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(event: event),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Pallete.neutral0,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: Colors.grey,
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '$formattedDate at $formattedTime',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    event.location,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    'Created by ${event.creatorId}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
