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
    final formattedDate = DateFormat('EEE, MMM d, y')
        .format(event.dateTime); // Format the event date
    final formattedTime =
        DateFormat('h:mm a').format(event.dateTime); // Format the event time

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsScreen(
                event:
                    event), // Navigate to the EventDetailsScreen when the card is tapped
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: Pallete.neutral0, // Set the background color of the container
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey
                  .withOpacity(0.3), // Set the color and opacity of the shadow
              spreadRadius: 1, // Set the spread radius of the shadow
              blurRadius: 5, // Set the blur radius of the shadow
              offset: const Offset(0, 3), // Set the offset of the shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80',
                fit: BoxFit
                    .cover, // Set the fit of the image within the container
              ),
            ),
            Padding(
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
                          event.title,
                          style: const TextStyle(
                            fontWeight: FontWeight
                                .bold, // Set the font weight of the title
                            fontSize: 18.0, // Set the font size of the title
                          ),
                          overflow: TextOverflow
                              .ellipsis, // Handle text overflow by ellipsis
                          maxLines: 2, // Limit the title to 2 lines
                        ),
                      ),
                      if (showJoinButton)
                        ElevatedButton(
                          onPressed: onJoinPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Pallete
                                .primary100, // Set the background color of the button
                            textStyle: const TextStyle(
                              color: Pallete
                                  .neutral0, // Set the text color of the button
                              fontSize:
                                  16, // Set the font size of the button text
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  8), // Set the border radius of the button
                            ),
                            minimumSize: const Size(
                                100, 48), // Set the minimum size of the button
                          ),
                          child:
                              const Text('Join'), // Set the text of the button
                        ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        color: Pallete.primary100, // Set the color of the icon
                        size: 16.0, // Set the size of the icon
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '$formattedDate at $formattedTime', // Display the formatted date and time
                        style: const TextStyle(
                          color: Pallete.primary100, // Set the text color
                          fontSize: 14.0, // Set the font size
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Pallete.primary100, // Set the color of the icon
                        size: 16.0, // Set the size of the icon
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        event.location, // Display the event location
                        style: const TextStyle(
                          color: Pallete.primary100, // Set the text color
                          fontSize: 14.0, // Set the font size
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Pallete.primary100, // Set the color of the icon
                        size: 16.0, // Set the size of the icon
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Created by ${event.creatorId}', // Display the creator ID
                        style: const TextStyle(
                          color: Pallete.primary100, // Set the text color
                          fontSize: 14.0, // Set the font size
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
