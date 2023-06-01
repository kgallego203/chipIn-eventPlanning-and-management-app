import 'package:chip_in/constants/appwrite_constants.dart';
import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/services/event_service.dart';
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
    _eventService = EventService(
        client: AppwriteAuth.client,
        endpoint: AppwriteConstants.endPoint,
        projectId: AppwriteConstants.projectId); // Initialize the EventService
    _fetchEvents(); // Fetch events from Appwrite
  }

  Future<void> _fetchEvents() async {
    List<Event> events = await _eventService.getAllEvents();
    setState(() {
      _eventList = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Event'),
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
                  child: ListTile(
                    title: Text(event.title),
                    subtitle: Text(event.description),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // TODO: Join the event
                      },
                      child: const Text('Join'),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
