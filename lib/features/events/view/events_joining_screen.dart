import 'package:chip_in/features/auth/services/user_service.dart';
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
  List<MyEventModel> allEvents = [];
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    fetchAllEvents();
    getCurrentUserId();
  }

  Future<void> getCurrentUserId() async {
    currentUserId = await UserService.getCreatorId();
  }

  Future<void> fetchAllEvents() async {
    try {
      List<MyEventModel> events = await EventService.getAllEvents();
      setState(() {
        allEvents = events;
      });
    } catch (error) {
      // Handle error
    }
  }

  Future<void> joinEvent(MyEventModel event) async {
    // TODO: Implement join event logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Events'),
      ),
      body: allEvents.isEmpty
          ? const Center(
              child: Text('No events to join'),
            )
          : ListView.builder(
              itemCount: allEvents.length,
              itemBuilder: (context, index) {
                MyEventModel event = allEvents[index];
                bool showJoinButton = event.creatorId != currentUserId;
                return EventCard(
                  event: event,
                  showJoinButton: showJoinButton,
                  onJoinPressed: () => joinEvent(event),
                );
              },
            ),
    );
  }
}
