import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/view/event_details_screen.dart';

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
      child: Card(
        color: Pallete.neutral0, // Set the background color of the card
        child: ListTile(
          title: Text(
            event.title, // Set the title of the event
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
                    Icons
                        .access_time, // Add an icon to indicate the time of the event
                    color: Colors.grey,
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    '$formattedDate at $formattedTime', // Display the formatted date and time of the event
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
                    Icons
                        .location_on, // Add an icon to indicate the location of the event
                    color: Colors.grey,
                    size: 16.0,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    event.location, // Display the location of the event
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
