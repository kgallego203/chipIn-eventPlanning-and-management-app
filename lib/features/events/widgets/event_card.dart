import 'package:chip_in/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chip_in/features/events/models/event_model.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd MMMM yyyy');
    final timeFormat = DateFormat('hh:mm a');

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              dateFormat.format(event.dateTime),
              style: TextStyle(
                fontSize: 16.0,
                color: Pallete.neutral70,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              timeFormat.format(event.dateTime),
              style: TextStyle(
                fontSize: 16.0,
                color: Pallete.neutral70,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              event.location,
              style: TextStyle(
                fontSize: 16.0,
                color: Pallete.neutral70,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Join',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Pallete.neutral0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Pallete.success100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Details',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Pallete.neutral0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Pallete.primary100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 12.0,
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
