import 'package:flutter/material.dart';
import 'login_widget.dart';
import 'signup_widget.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.login), text: "Login"),
              Tab(icon: Icon(Icons.person_add), text: "Sign Up"),
            ],
          ),
          title: const Text('Authentication'),
        ),
        body: TabBarView(
          children: [
            LoginWidget(),
            SignUpWidget(),
          ],
        ),
      ),
    );
  }
}
