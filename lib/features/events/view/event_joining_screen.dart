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
  // Initialize the EventService with the Appwrite client, endpoint, and project ID
  final EventService _eventService = EventService(
      client: AppwriteAuth.client,
      endpoint: AppwriteConstants.endPoint,
      projectId: AppwriteConstants.projectId);
  late List<Event>
      _eventList; // late keyword to let Dart know that you will use this private instance variable later in the code

  // TODO: Try to encapsulate these codes
  @override
  void initState() {
    super.initState();
    _eventList = [];
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
                      style: const TextStyle(
                        color: Pallete.neutral100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      event.description,
                      style: const TextStyle(
                        color: Pallete.neutral70,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () async {
                        // TODO: This block of code still does not join the user to an event when they click the button
                        String userId = await AppwriteAuth
                            .getCreatorId(); // Retrieve the id of the currently logged in user
                        _eventService.joinEvent(event.id,
                            userId); // event.id is the id of the event to join and it came from Event class. userId is the id of the currently logged in user and it came from auth_service.dart
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Pallete.primary100,
                        foregroundColor: Pallete.neutral0,
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
