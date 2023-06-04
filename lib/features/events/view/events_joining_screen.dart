import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/services/event_service.dart';

class JoinEventsScreen extends StatefulWidget {
  final EventService eventService;

  const JoinEventsScreen({required this.eventService});

  @override
  _JoinEventsScreenState createState() => _JoinEventsScreenState();
}

class _JoinEventsScreenState extends State<JoinEventsScreen> {
  List<Event> allEvents = [];

  @override
  void initState() {
    super.initState();
    fetchAllEvents();
  }

  Future<void> fetchAllEvents() async {
    try {
      List<Event> events = await widget.eventService.getAllEvents();
      setState(() {
        allEvents = events;
      });
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Events'),
        backgroundColor: Pallete.primary100,
      ),
      body: Container(
        color: Pallete.neutral10,
        child: ListView.builder(
          itemCount: allEvents.length,
          itemBuilder: (context, index) {
            Event event = allEvents[index];
            final formattedDate =
                DateFormat('EEE, MMM d, y').format(event.dateTime);
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
          },
        ),
      ),
    );
  }
}
