import 'package:chip_in/constants/appwrite_constants.dart';
import 'package:chip_in/services/authentication_service.dart';
import 'package:chip_in/services/event_service.dart';
import 'package:flutter/material.dart';
import '../events/event_creation_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> origin/main
                  builder: (context) => EventCreationScreen(
                    eventService: EventService(
                        client: AppwriteAuth.client,
                        endpoint: AppwriteConstants.endPoint,
                        projectId: AppwriteConstants.projectId),
                  ),
                ),
<<<<<<< HEAD
=======
=======
                    builder: (context) => EventCreationScreen(
                          eventService: EventService(
                              client: AppwriteAuth.client,
                              endpoint: AppwriteConfig.endPoint,
                              projectId: AppwriteConfig.projectId),
                        )),
>>>>>>> improving-code
>>>>>>> origin/main
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
