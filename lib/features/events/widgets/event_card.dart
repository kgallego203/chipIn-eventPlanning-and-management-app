import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/view/event_details_screen.dart';
import 'package:chip_in/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event; // The event object that this card represents

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat(
        'dd MMMM yyyy'); // A date formatter for formatting the event date
    final timeFormat =
        DateFormat('hh:mm a'); // A date formatter for formatting the event time

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16.0), // Rounded corners for the card
      ),
      elevation: 4.0, // Elevation for the card
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for the card content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.title, // The event title
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0), // A sized box for spacing
            Text(
              dateFormat.format(event.dateTime), // The formatted event date
              style: const TextStyle(
                fontSize: 16.0,
                color: Pallete.neutral70, // A neutral color for the text
              ),
            ),
            const SizedBox(height: 8.0), // A sized box for spacing
            Text(
              timeFormat.format(event.dateTime), // The formatted event time
              style: const TextStyle(
                fontSize: 16.0,
                color: Pallete.neutral70, // A neutral color for the text
              ),
            ),
            const SizedBox(height: 8.0), // A sized box for spacing
            Text(
              event.location, // The event location
              style: const TextStyle(
                fontSize: 16.0,
                color: Pallete.neutral70, // A neutral color for the text
              ),
            ),
            const SizedBox(height: 16.0), // A sized box for spacing
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed:
                      () {}, // A placeholder function for the "Join" button
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Pallete.success100, // A success color for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Rounded corners for the button
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'Join', // The text for the "Join" button
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Pallete.neutral0, // A neutral color for the text
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(
                            event:
                                event), // Navigate to the event details screen when the "Details" button is pressed
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Pallete.primary100, // A primary color for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Rounded corners for the button
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                  child: const Text(
                    'Details', // The text for the "Details" button
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Pallete.neutral0, // A neutral color for the text
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
