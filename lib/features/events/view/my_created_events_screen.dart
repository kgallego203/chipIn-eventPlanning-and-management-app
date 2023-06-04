import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:flutter/material.dart';

class MyCreatedEventsScreen extends StatefulWidget {
  final EventService eventService;

  const MyCreatedEventsScreen({required this.eventService});

  @override
  _MyCreatedEventsScreenState createState() => _MyCreatedEventsScreenState();
}

class _MyCreatedEventsScreenState extends State<MyCreatedEventsScreen> {
  List<Event> myCreatedEvents = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchMyCreatedEvents();
  }

  Future<void> fetchMyCreatedEvents() async {
    try {
      String userId = await AppwriteAuth.getCreatorId(); // Obtain the user ID
      List<Event> events = await widget.eventService
          .getMyCreatedEvents(userId); // Pass the user ID as an argument
      setState(() {
        myCreatedEvents = events;
        loading = false;
      });
    } catch (error) {
      setState(() {
        loading = false;
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Created Events'),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : myCreatedEvents.isEmpty
              ? Center(child: Text('No events created'))
              : ListView.builder(
                  itemCount: myCreatedEvents.length,
                  itemBuilder: (context, index) {
                    Event event = myCreatedEvents[index];
                    return ListTile(
                      title: Text(event.title),
                      subtitle: Text(event.location),
                      // Add other event details as needed
                      onTap: () {
                        // Handle event tapping
                      },
                    );
                  },
                ),
    );
  }
}
