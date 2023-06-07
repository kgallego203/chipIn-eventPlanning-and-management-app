import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/view/event_details_screen.dart';

class EventCard extends StatelessWidget {
  final MyEventModel event;
  final bool showJoinButton;
  final VoidCallback? onJoinPressed;

  const EventCard({
    required this.event,
    this.showJoinButton = true,
    this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE, MMM d, y').format(event.dateTime);
    final formattedTime = DateFormat('h:mm a').format(event.dateTime);

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
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
                        color: Pallete.neutral70,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '$formattedDate at $formattedTime',
                        style: const TextStyle(
                          color: Pallete.neutral70,
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
                        color: Pallete.neutral70,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        event.location,
                        style: const TextStyle(
                          color: Pallete.neutral70,
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
                        color: Pallete.neutral70,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Created by ${event.creatorId}',
                        style: const TextStyle(
                          color: Pallete.neutral70,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  if (showJoinButton)
                    ElevatedButton(
                      onPressed: onJoinPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.primary100,
                        textStyle: const TextStyle(
                          color: Pallete.neutral0,
                          fontSize: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: const Size(double.infinity, 48),
                      ),
                      child: const Text('Join'),
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
