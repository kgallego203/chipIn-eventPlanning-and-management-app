import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/features/auth/view/authentication_screen.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:chip_in/features/events/view/event_creation_screen.dart';
import 'package:chip_in/features/events/view/my_created_events_screen.dart';
import 'package:chip_in/features/events/view/events_joining_screen.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import '/constants/appwrite_constants.dart';

/*
TODO: MyJoined Events button
 */

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create an instance of EventService with the client, endpoint, and projectId from AppwriteAuth and AppwriteConstants
    final eventService = EventService(
      client: AppwriteAuth.client,
      endpoint: AppwriteConstants.endPoint,
      projectId: AppwriteConstants.projectId,
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
        // Set the elevatedButtonTheme for the ThemeData
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
        // Set the appBar for the Scaffold widget
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Home Page'),
          backgroundColor: Theme.of(context)
              .primaryColor, // Use primaryColor from current theme
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                // Build the menu items for the PopupMenuButton
                return [
                  const PopupMenuItem(
                    value:
                        'view_profile', // Set value to identify menu item when selected
                    child: Text(
                        'View Profile'), // Set text to display for menu item
                  ),
                  PopupMenuItem(
                    value:
                        'logout', // Set value to identify menu item when selected
                    child: const Text(
                        'Logout'), // Set text to display for menu item
                    onTap: () async {
                      // Function to execute when menu item is tapped
                      await AppwriteAuth.logout();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AuthenticationScreen(),
                        ),
                      );
                    },
                  ),
                ];
              },
              onSelected: (value) {
                // Function to execute when a menu item is selected
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
          // Center the child widget horizontally and vertically within the parent widget
          child: Column(
            // Arrange child widgets in a vertical array
            mainAxisAlignment: MainAxisAlignment
                .center, // Center child widgets along the main axis (vertically)
            children: [
              ElevatedButton(
                // Create an ElevatedButton widget
                onPressed: () {
                  // Function to execute when button is pressed
                  Navigator.push(
                    // Navigate to a new screen using MaterialPageRoute
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventCreationScreen(
                        // Navigate to EventCreationScreen and pass eventService as an argument
                        eventService: eventService,
                      ),
                    ),
                  );
                },
                child:
                    const Text('Create Event'), // Set text to display on button
              ),
              const SizedBox(
                  height:
                      16), // Create an empty box with a specified height to add space between widgets
              ElevatedButton(
                // Create an ElevatedButton widget
                onPressed: () {
                  // Function to execute when button is pressed
                  Navigator.push(
                    // Navigate to a new screen using MaterialPageRoute
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyCreatedEventsScreen(
                        // Navigate to MyCreatedEventsScreen and pass eventService as an argument
                        eventService: eventService,
                      ),
                    ),
                  );
                },
                child: const Text(
                    'My Created Events'), // Set text to display on button
              ),
              const SizedBox(
                  height:
                      16), // Create an empty box with a specified height to add space between widgets
              ElevatedButton(
                // Create an ElevatedButton widget
                onPressed: () {
                  // Function to execute when button is pressed
                  Navigator.push(
                    // Navigate to a new screen using MaterialPageRoute
                    context,
                    MaterialPageRoute(
                      builder: (context) => JoinEventsScreen(
                        // Navigate to JoinEventsScreen and pass eventService as an argument
                        eventService: eventService,
                      ),
                    ),
                  );
                },
                child:
                    const Text('Join Events'), // Set text to display on button
              ),
              const SizedBox(
                  height:
                      16), // Create an empty box with a specified height to add space between widgets
              ElevatedButton(
                onPressed:
                    () {}, // Empty function for onPressed (button does nothing when pressed)
                child: const Text(
                    'My Joined Events'), // Set text to display on button
              ),
            ],
          ),
        ),
      ),
    );
  }
}
