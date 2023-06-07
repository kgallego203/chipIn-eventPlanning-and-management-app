import 'package:chip_in/features/auth/services/user_service.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:chip_in/features/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

class MyJoinedEventsScreen extends StatefulWidget {
  final EventService eventService;

  const MyJoinedEventsScreen({required this.eventService});

  @override
  _MyJoinedEventsScreenState createState() => _MyJoinedEventsScreenState();
}

class _MyJoinedEventsScreenState extends State<MyJoinedEventsScreen> {
  List<MyEventModel> myJoinedEvents =
      []; // Create a list to hold the user's joined events
  bool loading =
      true; // Create a boolean to track whether the events are still loading

  @override
  void initState() {
    super.initState();
    fetchMyJoinedEvents(); // Call the fetchMyJoinedEvents method when the screen is initialized
  }

  Future<void> fetchMyJoinedEvents() async {
    try {
      String userId = await UserService.getCreatorId(); // Obtain the user ID
      List<MyEventModel> events = await widget.eventService.getMyJoinedEvents(
          userId); // Call the getMyJoinedEvents method of the eventService and pass in the user ID
      setState(() {
        myJoinedEvents =
            events; // Set the myJoinedEvents list to the events returned by the getMyJoinedEvents method
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
        title: const Text('My Joined Events'), // Set the title of the app bar
      ),
      body: loading // If the events are still loading
          ? const Center(
              child: CircularProgressIndicator()) // Show a loading indicator
          : myJoinedEvents.isEmpty // If the user has not joined any events
              ? const Center(
                  child: Text(
                      'You have not joined any events')) // Show a message indicating that no events have been joined
              : ListView.builder(
                  itemCount: myJoinedEvents
                      .length, // Set the number of items in the list view to the length of the myJoinedEvents list
                  itemBuilder: (context, index) {
                    MyEventModel event = myJoinedEvents[
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
