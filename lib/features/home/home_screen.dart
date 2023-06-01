import 'package:chip_in/features/auth/services/auth_service.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import '/features/events/view/event_creation_screen.dart';
import '/features/events/services/event_service.dart';
import '/constants/appwrite_constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double>? _animation;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleOptions() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.neutral0, // background color of scaffold
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Pallete.primary200, // color of AppBar
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Event Listing',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Event ${index + 1}'),
                      subtitle: Text('Event description'),
                      trailing: const Icon(Icons.arrow_forward_ios,
                          color: Pallete.primary300), // color of trailing icon
                      onTap: () {
                        // TODO: Implement event details screen
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                bottom: 80 * (_animation?.value ?? 0),
                right: 16,
                child: Opacity(
                  opacity: _animation?.value ?? 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton.extended(
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
                          _toggleOptions();
                        },
                        label: const Text('Create Event'),
                        icon: const Icon(Icons.add),
                        backgroundColor: Pallete.success100,
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton.extended(
                        onPressed: () {
                          // TODO: Implement event joining screen
                          _toggleOptions();
                        },
                        label: const Text('Join Event'),
                        icon: const Icon(Icons.group_add),
                        backgroundColor: Pallete
                            .information100, // color of floating action button
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleOptions,
        child: const Icon(Icons.add),
        backgroundColor: Pallete.primary200, // color of floating action button
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'My Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'My Own Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor:
            Pallete.primary300, // selected item color in bottom navigation bar
        unselectedItemColor:
            Pallete.neutral50, // unselected item color in bottom navigation bar
        onTap: _onItemTapped,
        backgroundColor:
            Pallete.neutral10, // background color of bottom navigation bar
      ),
    );
  }
}
