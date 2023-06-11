import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userId = '';
  String userName = '';
  String password = '';
  String profilePicture = '';
  String additionalDetails = '';
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'User ID',
              ),
              onChanged: (value) {
                setState(() {
                  userId = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'User Name',
              ),
              onChanged: (value) {
                setState(() {
                  userName = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Profile Picture',
              ),
              onChanged: (value) {
                setState(() {
                  profilePicture = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Additional Details',
              ),
              onChanged: (value) {
                setState(() {
                  additionalDetails = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              onChanged: (value) {
                setState(() {
                  phoneNumber = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Save profile data to database
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
