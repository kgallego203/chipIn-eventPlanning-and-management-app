import 'package:chip_in/features/events/widgets/event_card.dart'; // Import the EventCard widget
import 'package:flutter/material.dart';
import 'package:chip_in/features/auth/services/user_service.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/services/event_service.dart';

class MyCreatedEventsScreen extends StatefulWidget {
  final EventService eventService;

  const MyCreatedEventsScreen({required this.eventService});

  @override
  _MyCreatedEventsScreenState createState() => _MyCreatedEventsScreenState();
}

class _MyCreatedEventsScreenState extends State<MyCreatedEventsScreen> {
  List<Event> myCreatedEvents =
      []; // Create a list to hold the user's created events
  bool loading =
      true; // Create a boolean to track whether the events are still loading

  @override
  void initState() {
    super.initState();
    fetchMyCreatedEvents(); // Call the fetchMyCreatedEvents method when the screen is initialized
  }

  Future<void> fetchMyCreatedEvents() async {
    try {
      String userId = await AppwriteAuth.getCreatorId(); // Obtain the user ID
      List<Event> events = await widget.eventService.getMyCreatedEvents(
          userId); // Call the getMyCreatedEvents method of the eventService and pass in the user ID
      setState(() {
        myCreatedEvents =
            events; // Set the myCreatedEvents list to the events returned by the getMyCreatedEvents method
        loading = false; // Set loading to false
      });
    } catch (error) {
      setState(() {
        loading = false; // Set loading to false
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Created Events'), // Set the title of the app bar
      ),
      body: loading // If the events are still loading
          ? const Center(
              child: CircularProgressIndicator()) // Show a loading indicator
          : myCreatedEvents.isEmpty // If the user has not created any events
              ? const Center(
                  child: Text(
                      'You do not have events created')) // Show a message indicating that no events have been created
              : ListView.builder(
                  itemCount: myCreatedEvents
                      .length, // Set the number of items in the list view to the length of the myCreatedEvents list
                  itemBuilder: (context, index) {
                    Event event = myCreatedEvents[
                        index]; // Get the event at the current index
                    return EventCard(
                        event: event,
                        showJoinButton:
                            false); // Use the updated EventCard widget without the join button
                  },
                ),
    );
  }
}
