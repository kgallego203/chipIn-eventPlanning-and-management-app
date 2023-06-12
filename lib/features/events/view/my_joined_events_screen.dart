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
  List<MyEventModel> myJoinedEvents = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchMyJoinedEvents();
  }

  Future<void> fetchMyJoinedEvents() async {
    try {
      String userId = await UserService.getCreatorId();
      List<MyEventModel> events =
          await widget.eventService.getMyJoinedEvents(userId);
      setState(() {
        myJoinedEvents = events;
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
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (myJoinedEvents.isEmpty) {
      return const Center(
        child: Text('You have not joined any events'),
      );
    } else {
      return ListView.builder(
        itemCount: myJoinedEvents.length,
        itemBuilder: (context, index) {
          MyEventModel event = myJoinedEvents[index];
          return EventCard(
            event: event,
            showJoinButton: false,
          );
        },
      );
    }
  }
}
