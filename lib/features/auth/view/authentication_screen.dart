import 'package:flutter/material.dart';
import 'login_view.dart';
import 'signup_view.dart';
import '/themes/theme.dart';

// This class represents the authentication screen widget
class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  int _selectedIndex =
      0; // Keeps track of the selected bottom navigation bar item

  static final List<Widget> _widgetOptions = <Widget>[
    LoginView(), // First widget option: LoginView widget
    SignUpView(), // Second widget option: SignUpView widget
  ];

  // Callback function called when a bottom navigation bar item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'chipIn',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Pallete.primary100,
              ),
            ),
            Row(
              children: [
                Text(
                  'powered by ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Pallete.neutral70,
                  ),
                ),
                Text(
                  'Flutter',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF02569B),
                  ),
                ),
                Text(
                  ' and ',
                  style: TextStyle(
                    fontSize: 12,
                    color: Pallete.neutral70,
                  ),
                ),
                Text(
                  'Appwrite',
                  style: TextStyle(
                    fontSize: 15,
                    fontStyle: FontStyle.italic,
                    color: Pallete.primary300,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Pallete.neutral0,
        toolbarHeight: 100, // Increase this number to make the AppBar taller
      ),
      body: Center(
        child: _widgetOptions
            .elementAt(_selectedIndex), // Display the selected widget
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Sign Up',
          ),
        ],
        currentIndex: _selectedIndex, // Set the currently selected item
        selectedItemColor: Pallete.primary100, // Color of the selected item
        unselectedItemColor: Pallete.neutral70, // Color of unselected items
        onTap: _onItemTapped, // Callback function when an item is tapped
      ),
    );
  }
}
