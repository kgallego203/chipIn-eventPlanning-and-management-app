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
  List<MyEventModel> myJoinedEvents = []; // List to store the joined events
  bool loading = true; // Variable to track if the events are loading

  @override
  void initState() {
    super.initState();
    fetchMyJoinedEvents(); // Fetch the joined events when the screen is initialized
  }

  Future<void> fetchMyJoinedEvents() async {
    try {
      String userId = await UserService
          .getCreatorId(); // Get the current user ID using the UserService
      List<MyEventModel> events = await widget.eventService.getMyJoinedEvents(
          userId); // Fetch the joined events using the EventService
      setState(() {
        myJoinedEvents =
            events; // Update the list of joined events in the state
        loading = false; // Set loading to false once the events are fetched
      });
    } catch (error) {
      setState(() {
        loading = false; // Set loading to false in case of an error
      });
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child:
            CircularProgressIndicator(), // Display a loading indicator while the events are being fetched
      );
    } else if (myJoinedEvents.isEmpty) {
      return const Center(
        child: Text(
            'You have not joined any events'), // Display a message if there are no joined events
      );
    } else {
      return ListView.builder(
        itemCount: myJoinedEvents.length,
        itemBuilder: (context, index) {
          MyEventModel event =
              myJoinedEvents[index]; // Get the event at the current index
          return EventCard(
            event: event, // Pass the event to the EventCard widget
            showJoinButton:
                false, // Set showJoinButton to false since these are already joined events
          );
        },
      );
    }
  }
}
