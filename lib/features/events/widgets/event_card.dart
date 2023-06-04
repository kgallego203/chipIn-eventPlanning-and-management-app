import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:chip_in/features/events/models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE, MMM d, y').format(event.dateTime);
    final formattedTime = DateFormat('h:mm a').format(event.dateTime);

    return Card(
      color: Pallete.neutral0,
      child: ListTile(
        title: Text(
          event.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                    color: Colors.black,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
            Text(
              event.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: () {
            // Handle join button press
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete.primary100,
            foregroundColor: Pallete.neutral0,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Join'),
        ),
        onTap: () {
          // Handle event tapping
        },
      ),
    );
  }
}
