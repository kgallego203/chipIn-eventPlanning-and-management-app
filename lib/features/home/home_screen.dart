import 'package:carousel_slider/carousel_slider.dart';
import 'package:chip_in/features/auth/services/user_service.dart';
import 'package:chip_in/features/auth/view/authentication_screen.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/features/events/services/event_service.dart';
import 'package:chip_in/features/events/view/event_creation_screen.dart';
import 'package:chip_in/features/events/view/events_joining_screen.dart';
import 'package:chip_in/features/events/view/my_created_events_screen.dart';
import 'package:chip_in/features/events/view/my_joined_events_screen.dart';
import 'package:chip_in/features/events/widgets/event_card.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class HomePageLayout extends StatelessWidget {
  const HomePageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 15.0),
        Expanded(
          child: FutureBuilder<List<MyEventModel>>(
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
                    height: 500,
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
        ),
      ],
    );
  }
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomePageLayout(),
    MyJoinedEventsScreen(eventService: EventService()),
    MyCreatedEventsScreen(eventService: EventService()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: Palette.neutral0,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Palette.neutral100,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Palette.neutral100,
            fontSize: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Palette.primary100,
            textStyle: const TextStyle(
              color: Palette.neutral0,
              fontSize: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: const Size(200, 48),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: FutureBuilder<String>(
            future: UserService.getUserName(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userName = snapshot.data!;
                return Text('Welcome, $userName!');
              } else {
                return const Text('Home Page');
              }
            },
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'logout',
                    child: Text('Logout'),
                  ),
                ];
              },
              onSelected: (value) async {
                if (value == 'logout') {
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
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Joined Events',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event),
              label: 'My Events',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: _onItemTapped,
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(size: 22.0),
          backgroundColor: Palette.primary100,
          visible: true,
          curve: Curves.bounceIn,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.add, color: Colors.white),
              backgroundColor: Colors.deepOrange,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventCreationScreen(
                      eventService: EventService(),
                    ),
                  ),
                );
              },
              label: 'Create Event',
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              labelBackgroundColor: Colors.deepOrangeAccent,
            ),
            SpeedDialChild(
              child: const Icon(Icons.arrow_upward, color: Colors.white),
              backgroundColor: Colors.deepPurple,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JoinEventsScreen(
                      eventService: EventService(),
                    ),
                  ),
                );
              },
              label: 'Join Events',
              labelStyle: const TextStyle(fontWeight: FontWeight.w500),
              labelBackgroundColor: Colors.deepPurpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}
