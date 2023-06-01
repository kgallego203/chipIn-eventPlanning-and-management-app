import 'package:chip_in/features/events/models/event_model.dart';
import 'package:flutter/material.dart';

class EventJoiningScreen extends StatefulWidget {
  const EventJoiningScreen({Key? key}) : super(key: key);

  @override
  _EventJoiningScreenState createState() => _EventJoiningScreenState();
}

class _EventJoiningScreenState extends State<EventJoiningScreen> {
  late List<Event> _eventList;

  @override
  void initState() {
    super.initState();
    _eventList = []; // TODO: Fetch events from Appwrite
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Event'),
      ),
      body: ListView.builder(
        itemCount: _eventList.length,
        itemBuilder: (context, index) {
          final event = _eventList[index];
          return ListTile(
            title: Text(event.title), // Use event.title instead of event.name
            subtitle: Text(event.description),
            trailing: ElevatedButton(
              onPressed: () {
                // TODO: Join the event
              },
              child: const Text('Join'),
            ),
          );
        },
      ),
    );
  }
}
