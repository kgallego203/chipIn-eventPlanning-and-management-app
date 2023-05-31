import 'package:flutter/material.dart';
import 'login_view.dart';
import 'signup_view.dart';
import '/themes/theme.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'chipIn',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Pallete
                      .primary100, // Set the color of the "chipIn" text to primary100 from the Pallete class
                ),
              ),
              Text(
                'powered by Flutter and Appwrite',
                style: TextStyle(
                  fontSize: 12,
                  color: Pallete
                      .neutral70, // Set the color of the "powered by Flutter and Appwrite" text to neutral60 from the Pallete class
                ),
              ),
            ],
          ),
          backgroundColor: Pallete
              .neutral0, // Set the background color of the app bar to neutral0 from the Pallete class
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: Container(
              color: Pallete
                  .neutral0, // Set the background color of the tab bar to neutral0 from the Pallete class
              child: TabBar(
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
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Pallete
                      .primary100, // Set the color of the tab indicator to primary100 from the Pallete class
                ),
                labelColor: Pallete
                    .neutral0, // Set the color of the selected tab label to neutral0 from the Pallete class
                unselectedLabelColor: Pallete
                    .neutral70, // Set the color of the unselected tab label to neutral70 from the Pallete class
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            LoginView(),
            SignUpView(),
          ],
        ),
      ),
    );
  }
}
