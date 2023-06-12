import 'package:chip_in/features/auth/services/user_service.dart';
import 'package:chip_in/features/events/models/attendees_model.dart';
import 'package:chip_in/features/events/widgets/event_card.dart';
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
  Future<void> joinEvent(MyEventModel event) async {
    AttendeesModel myAttendeeModel = AttendeesModel(
      eventId: event.eventId,
      userId: currentUserId,
    ); // Create an instance of AttendeesModel with the event ID and the current user ID
    bool result = await EventService.joinEvent(
        myAttendeeModel); // Call the joinEvent method from the EventService
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Successfully joined event!'), // Display a success message in a SnackBar
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Failed to join event. Please try again.'), // Display an error message in a SnackBar
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  List<MyEventModel> allEvents = []; // List to store all the events
  String currentUserId = ''; // Variable to store the current user ID

  @override
  void initState() {
    super.initState();
    fetchAllEvents(); // Fetch all the events when the screen is initialized
    getCurrentUserId(); // Get the current user ID when the screen is initialized
  }

  Future<void> getCurrentUserId() async {
    currentUserId = await UserService
        .getCreatorId(); // Get the current user ID using the UserService
  }

  Future<void> fetchAllEvents() async {
    try {
      List<MyEventModel> events = await EventService
          .getAllEvents(); // Fetch all the events using the EventService
      setState(() {
        allEvents = events; // Update the list of events in the state
      });
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Events'), // Set the title of the AppBar
      ),
      body: allEvents.isEmpty
          ? const Center(
              child: Text(
                  'No events to join'), // Display a message if there are no events to join
            )
          : ListView.builder(
              itemCount: allEvents.length,
              itemBuilder: (context, index) {
                MyEventModel event =
                    allEvents[index]; // Get the event at the current index
                bool showJoinButton = event.creatorId !=
                    currentUserId; // Determine whether to show the join button based on the creator ID
                return EventCard(
                  event: event, // Pass the event to the EventCard widget
                  showJoinButton:
                      showJoinButton, // Pass whether to show the join button
                  onJoinPressed: () =>
                      joinEvent(event), // Pass the joinEvent callback function
                );
              },
            ),
    );
  }
}
