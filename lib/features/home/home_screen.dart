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
import 'package:chip_in/features/profile/view/profile_screen.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// The home page widget
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// Layout widget for the home page
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
          background: Pallete.neutral0, // Set the background color of the theme
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Pallete
                .neutral100, // Set the text color of the displayLarge style
            fontSize: 24, // Set the font size of the displayLarge style
            fontWeight: FontWeight
                .bold, // Set the font weight of the displayLarge style
          ),
          bodyLarge: TextStyle(
            color:
                Pallete.neutral100, // Set the text color of the bodyLarge style
            fontSize: 16, // Set the font size of the bodyLarge style
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Pallete
                .primary100, // Set the background color of the elevated button
            textStyle: const TextStyle(
              color:
                  Pallete.neutral0, // Set the text color of the elevated button
              fontSize: 16, // Set the font size of the elevated button
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  8), // Set the border radius of the elevated button
            ),
            minimumSize: const Size(
                200, 48), // Set the minimum size of the elevated button
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
                return Text(
                    'Welcome, $userName!'); // Display the username in the app bar title
              } else {
                return const Text('Home Page');
              }
            },
          ),
          backgroundColor: Theme.of(context)
              .primaryColor, // Set the background color of the app bar
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
          selectedItemColor: Theme.of(context)
              .primaryColor, // Set the color of the selected item in the bottom navigation bar
          onTap: _onItemTapped,
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(size: 22.0),
          backgroundColor:
              Pallete.primary100, // Set the background color of the speed dial
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
