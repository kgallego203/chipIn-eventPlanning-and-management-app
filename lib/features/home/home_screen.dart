import 'package:carousel_slider/carousel_slider.dart';
import 'package:chip_in/features/auth/services/user_service.dart';
import 'package:chip_in/features/auth/view/authentication_screen.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:chip_in/features/events/view/event_creation_screen.dart';
import 'package:chip_in/features/events/view/my_created_events_screen.dart';
import 'package:chip_in/features/events/view/events_joining_screen.dart';
import 'package:chip_in/features/events/view/my_joined_events_screen.dart';
import 'package:chip_in/features/events/widgets/event_card.dart';
import 'package:chip_in/features/profile/view/profile_screen.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: Pallete.primary100,
      textStyle: const TextStyle(
        color: Pallete.neutral0,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      minimumSize: const Size(200, 48), // Fixed button size
    );

    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: Pallete.neutral0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Pallete.neutral100,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Pallete.neutral100,
            fontSize: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: buttonStyle,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home Page'),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'view_profile',
                    child: Text('View Profile'),
                  ),
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ];
              },
              onSelected: (value) async {
                if (value == 'view_profile') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                } else if (value == 'logout') {
                  await UserService.logout();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => AuthenticationScreen(),
                    ),
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Upcoming Events',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            FutureBuilder<List<MyEventModel>>(
              future: EventService.getAllEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final events = snapshot.data!;
                  if (events.isEmpty) {
                    return const Text('No events to display');
                  }
                  return CarouselSlider.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index, _) {
                      return EventCard(event: events[index]);
                    },
                    options: CarouselOptions(
                      height: 400,
                      viewportFraction: 0.8,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayCurve: Curves.fastOutSlowIn,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventCreationScreen(
                      eventService: EventService(),
                    ),
                  ),
                );
              },
              child: const Text('Create Event'),
              style: buttonStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyCreatedEventsScreen(
                      eventService: EventService(),
                    ),
                  ),
                );
              },
              child: const Text('My Created Events'),
              style: buttonStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinEventsScreen(
                      eventService: EventService(),
                    ),
                  ),
                );
              },
              child: const Text('Join Events'),
              style: buttonStyle,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyJoinedEventsScreen(
                      eventService: EventService(),
                    ),
                  ),
                );
              },
              style: buttonStyle,
              child: const Text('My Joined Events'),
            ),
          ],
        ),
      ),
    );
  }
}
