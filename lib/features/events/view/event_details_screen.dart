import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:intl/intl.dart';

class EventDetailsScreen extends StatefulWidget {
  final MyEventModel event;

  EventDetailsScreen({required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final dateFormat =
        DateFormat('EEEE, MMMM d, y'); // Format for displaying the date
    final timeFormat = DateFormat('h:mm a'); // Format for displaying the time

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Pallete.primary200, // Set the background color of the AppBar
        title: const Text(
          'Event Details',
          style: TextStyle(
            color: Pallete.neutral0, // Set the text color of the AppBar title
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      widget.event.title,
                      style: const TextStyle(
                        color: Colors
                            .black, // Set the text color of the event title
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Action to perform when the button is pressed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Pallete
                          .primary100, // Set the background color of the button
                    ),
                    child: const Text(
                      'Join Event',
                      style: TextStyle(
                        color: Pallete
                            .neutral0, // Set the text color of the button
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(3),
                },
                border: TableBorder.symmetric(
                  inside: BorderSide.none,
                  outside: BorderSide.none,
                ),
                children: [
                  _buildTableRow(
                    'Date',
                    dateFormat.format(widget.event
                        .dateTime), // Format the event date using the specified format
                    Icons.calendar_today, // Icon for the date row
                  ),
                  _buildTableRow(
                    'Time',
                    timeFormat.format(widget.event
                        .dateTime), // Format the event time using the specified format
                    Icons.access_time, // Icon for the time row
                  ),
                  _buildTableRow(
                    'Location',
                    widget.event.location,
                    Icons.location_on, // Icon for the location row
                  ),
                  _buildTableRow(
                    'Description',
                    widget.event.description,
                    Icons.description, // Icon for the description row
                  ),
                  // Add other event details here (soon)
                  // ...
                ],
              ),
              const SizedBox(height: 16.0),
              Center(
                child: Image.network(
                  'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80',
                ), // This is just a demo image (will work on a feature where user can upload an image)
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value, IconData icon) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Pallete.primary100, // Set the color of the icon
              ),
              const SizedBox(width: 8.0),
              Text(
                label,
                style: const TextStyle(
                  color: Pallete.primary100, // Set the text color of the label
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(
              color: Pallete.neutral70, // Set the text color of the value
              fontSize: 18.0,
            ),
          ),
        ),
      ],
    );
  }
}
