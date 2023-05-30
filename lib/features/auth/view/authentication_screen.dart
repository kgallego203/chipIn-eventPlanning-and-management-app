import 'package:flutter/material.dart';
import 'login_view.dart';
import 'signup_view.dart';

/* The code defines an AuthenticationScreen class that creates a tab bar with two tabs: 
"Login" and "Sign Up". The DefaultTabController widget is used to set the length of the 
tab bar to 2 and the TabBarView widget is used to add the LoginWidget and SignUpWidget 
to the tab bar view. The AppBar widget is used to set the title of the app bar and define 
the tabs for the tab bar. */

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Set the length of the tab bar to 2
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              // Define the tabs for the tab bar
              Tab(icon: Icon(Icons.login), text: "Login"),
              Tab(icon: Icon(Icons.person_add), text: "Sign Up"),
            ],
          ),
          title: const Text('chipIn'), // Set the title of the app bar
        ),
        body: TabBarView(
          children: [
            LoginView(), // Add the Login Widget to the tab bar view
            SignUpView(), // Add the Sign Up Widget to the tab bar view
          ],
        ),
      ),
    );
  }
}
