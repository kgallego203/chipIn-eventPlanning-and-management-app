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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
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
                    .neutral70, // Set the color of the unselected tab label to neutral40 from the Pallete class
              ),
            ),
          ),
          title: const Text('chipIn'),
          backgroundColor: Pallete
              .neutral0, // Set the background color of the app bar to neutral0 from the Pallete class
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
