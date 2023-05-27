import 'package:chip_in/services/auth_service.dart';
import 'package:flutter/material.dart';

// Define a class for the Login Widget
class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

// Define a state for the Login Widget
class _LoginWidgetState extends State<LoginWidget> {
  // Define a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Define TextEditingController objects for the email and password fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Dispose of the TextEditingController objects when the widget is disposed
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Build the Login Widget
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email Text Field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),

            // Password Text Field
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            // Login Button
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  final email = _emailController.text;
                  final password = _passwordController.text;

                  AppwriteAuth.login(context, email, password);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
