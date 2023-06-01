import 'package:chip_in/constants/appwrite_constants.dart';
import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';

class EventJoiningScreen extends StatefulWidget {
  const EventJoiningScreen({Key? key}) : super(key: key);

  @override
  _EventJoiningScreenState createState() => _EventJoiningScreenState();
}

class _EventJoiningScreenState extends State<EventJoiningScreen> {
  late List<Event> _eventList;
  late EventService _eventService;

  @override
  void initState() {
    super.initState();
    _eventList = [];

    // Initialize the EventService with the Appwrite client, endpoint, and project ID
    _eventService = EventService(
        client: AppwriteAuth.client,
        endpoint: AppwriteConstants.endPoint,
        projectId: AppwriteConstants.projectId);

    // Fetch events from Appwrite
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    // Call the getAllEvents method of the EventService to fetch all events from Appwrite
    List<Event> events = await _eventService.getAllEvents();

    // Update the _eventList variable with the fetched events
    setState(() {
      _eventList = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Event'),
        backgroundColor: Pallete.primary100,
      ),
      body: _eventList.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _eventList.length,
              itemBuilder: (context, index) {
                final event = _eventList[index];
                return Card(
                  color: Pallete.neutral10,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    title: Text(
                      event.title,
                      style: TextStyle(
                        color: Pallete.neutral100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      event.description,
                      style: TextStyle(
                        color: Pallete.neutral70,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // TODO: Join the event
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Pallete.primary100,
                        onPrimary: Pallete.neutral0,
                      ),
                      child: const Text('Join'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
