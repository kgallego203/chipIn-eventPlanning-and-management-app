import 'package:chip_in/constants/appwrite_constants.dart';
import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:flutter/material.dart';
import '../events/view/event_creation_screen.dart';

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
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventCreationScreen(
                    eventService: EventService(
                        client: AppwriteAuth.client,
                        endpoint: AppwriteConstants.endPoint,
                        projectId: AppwriteConstants.projectId),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
