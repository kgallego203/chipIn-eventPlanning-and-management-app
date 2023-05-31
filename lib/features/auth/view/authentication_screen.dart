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
          backgroundColor: Pallete.neutral0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(72),
            child: Container(
              color: Pallete.neutral0,
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
                  color: Pallete.primary100,
                ),
                labelColor: Pallete.neutral0,
                unselectedLabelColor: Pallete.neutral70,
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
