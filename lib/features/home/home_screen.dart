import 'package:flutter/material.dart';

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

  static const List<Widget> _widgetOptions = <Widget>[
    Text('My Events'),
    Text('My Own Events'),
    Text('Logout'),
  ];

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
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Upcoming Events',
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
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: Implement event details screen
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          // AnimatedBuilder widget rebuilds the widget tree when the animation changes
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Positioned(
                bottom: 80 * (1 - (_animation?.value ?? 0)),
                right: 16,
                child: Opacity(
                  opacity: _animation?.value ?? 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {
                          // TODO: Implement event creation screen
                          _toggleOptions();
                        },
                        label: const Text('Create Event'),
                        icon: const Icon(Icons.add),
                      ),
                      const SizedBox(height: 16),
                      FloatingActionButton.extended(
                        onPressed: () {
                          // TODO: Implement event joining screen
                          _toggleOptions();
                        },
                        label: const Text('Join Event'),
                        icon: const Icon(Icons.group_add),
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
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
