import 'package:flutter/material.dart';
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
        title: const Text('Join Events'),
      ),
      body: ListView.builder(
        itemCount: allEvents.length,
        itemBuilder: (context, index) {
          Event event = allEvents[index];
          return ListTile(
            title: Text(event.title),
            subtitle: Text(event.location),
            onTap: () {
              // Handle event tapping
            },
          );
        },
      ),
    );
  }
}
