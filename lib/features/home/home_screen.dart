import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:chip_in/features/events/view/event_creation_screen.dart';
import 'package:chip_in/features/events/view/event_joining_screen.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import '/constants/appwrite_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventService = EventService(
      client: AppwriteAuth.client, // ensure you have AppwriteAuth.client
      endpoint: AppwriteConstants.endPoint,
      projectId: AppwriteConstants.projectId,
    );

    return Theme(
      data: ThemeData(
        primaryColor: Pallete.primary200,
        backgroundColor: Pallete.neutral0,
        scaffoldBackgroundColor: Pallete.neutral0,
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Pallete.neutral100,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            color: Pallete.neutral100,
            fontSize: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Pallete.primary200),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                color: Pallete.neutral0,
                fontSize: 16,
              ),
            ),
          ),
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
                return const [
                  PopupMenuItem(
                    value: 'view_profile',
                    child: Text('View Profile'),
                  ),
                  PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 'view_profile') {
                  // TODO: Implement view profile functionality
                } else if (value == 'logout') {
                  // TODO: Implement logout functionality
                }
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventCreationScreen(
                        eventService: eventService,
                      ),
                    ),
                  );
                },
                child: const Text('Create Event'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement My Created Events functionality
                },
                child: const Text('My Created Events'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EventJoiningScreen(),
                    ),
                  );
                },
                child: const Text('Join Events'),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement My Joined Events functionality
                },
                child: const Text('My Joined Events'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
