import 'package:chip_in/features/events/widgets/event_card.dart'; // Import the EventCard widget
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
  List<Event> allEvents = []; // Create a list to hold all the events

  @override
  void initState() {
    super.initState();
    fetchAllEvents(); // Call the fetchAllEvents method when the screen is initialized
  }

  Future<void> fetchAllEvents() async {
    try {
      List<Event> events = await widget.eventService
          .getAllEvents(); // Call the getAllEvents method of the eventService
      setState(() {
        allEvents =
            events; // Set the allEvents list to the events returned by the getAllEvents method
      });
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Events'), // Set the title of the app bar
      ),
      body: ListView.builder(
        itemCount: allEvents
            .length, // Set the number of items in the list view to the length of the allEvents list
        itemBuilder: (context, index) {
          Event event = allEvents[index]; // Get the event at the current index
          return EventCard(
              event: event); // Use the EventCard widget to display the event
        },
      ),
    );
  }
}
