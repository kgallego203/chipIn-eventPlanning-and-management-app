import 'package:flutter/material.dart';
import 'login_view.dart';
import 'signup_view.dart';
import '/themes/theme.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It's like an appbar but it has 2 tabs to navigate between Login and Signup forms
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // App bar title
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'chipIn',
                style: TextStyle(
                  fontSize: 24,
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
                      fontSize: 12,
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
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: Pallete.primary300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // App bar background color
          backgroundColor: Pallete.neutral0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: Container(
              color: Pallete.neutral0,
              child: TabBar(
                // Tabs
                tabs: const [
                  Tab(
                    icon: Icon(Icons.login),
                    text: "Login",
                  ),
                  Tab(
                    icon: Icon(Icons.person_add),
                    text: "Sign Up",
                  ),
                ],
                // Tab indicator
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Pallete.primary100,
                ),
                // Tab label colors
                labelColor: Pallete.neutral0,
                unselectedLabelColor: Pallete.neutral70,
              ),
            ),
          ),
        ),
        body: TabBarView(
          // Tab views
          children: [
            LoginView(),
            SignUpView(),
          ],
        ),
      ),
    );
  }
}
