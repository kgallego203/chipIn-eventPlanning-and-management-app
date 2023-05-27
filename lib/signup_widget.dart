import 'package:flutter/material.dart';

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            decoration: InputDecoration(hintText: 'Email'),
          ),
          const SizedBox(height: 10),
          const TextField(
            decoration: InputDecoration(hintText: 'Username'),
          ),
          const SizedBox(height: 10),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          const SizedBox(height: 10),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(hintText: 'Confirm Password'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Sign Up'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
