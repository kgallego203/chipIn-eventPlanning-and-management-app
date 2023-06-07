import 'package:flutter/material.dart';
import 'login_view.dart';
import 'signup_view.dart';
import '/themes/theme.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    LoginView(),
    SignUpView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
        child: _widgetOptions.elementAt(_selectedIndex),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Pallete.primary100,
        unselectedItemColor: Pallete.neutral70,
        onTap: _onItemTapped,
      ),
    );
  }
}
