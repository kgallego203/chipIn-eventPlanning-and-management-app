import 'package:chip_in/services/auth_service.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // First Name Text Field
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(hintText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),

            // Last Name Text Field
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(hintText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),

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

            // Username Text Field
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(hintText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),

            // Password Text Field
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),

            // Confirm Password Text Field
            TextFormField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(hintText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            // Sign Up Button
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () {
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  // Get the values of the form fields
                  final firstname = _firstNameController.text;
                  final lastname = _lastNameController.text;
                  final email = _emailController.text;
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  // Call the AppwriteAuth.signUp method to sign up the user
                  AppwriteAuth.signUp(
                      firstname, lastname, email, username, password);

                  // Clear the form fields after sign up success
                  _firstNameController.text = '';
                  _lastNameController.text = '';
                  _emailController.text = '';
                  _usernameController.text = '';
                  _passwordController.text = '';
                  _confirmPasswordController.text = '';

                  // Show a snackbar to indicate that the account was created
                  const snackBar = SnackBar(
                    content: Text('Account Created!'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
