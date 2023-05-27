// Import the necessary packages and files
import 'package:chip_in/services/auth_service.dart';
import 'package:flutter/material.dart';

/* The code defines a SignUpWidget class that creates a sign-up form with first name, 
last name, email, username, password, and confirm password text fields and a sign-up button. 
The form is validated using a GlobalKey<FormState> object and the TextEditingController 
objects are disposed of when the widget is disposed. When the sign-up button is pressed, 
the form fields are validated and the values are passed to the AppwriteAuth.createUser 
method to sign up the user. If successful, the form fields are cleared and a success 
snackbar is shown, and if there was an error, an error snackbar is shown. */

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

// Define a state for the SignUp Widget
class _SignUpWidgetState extends State<SignUpWidget> {
  // Define a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Define TextEditingController objects for the form fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Dispose of the TextEditingController objects when the widget is disposed
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

  // Build the SignUp Widget
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
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(value)) {
                  return 'Please enter a valid email address';
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
              onPressed: () async {
                // Check if the form is valid
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  // Get the values of the form fields
                  final firstname = _firstNameController.text;
                  final lastname = _lastNameController.text;
                  final email = _emailController.text;
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  try {
                    // Call the AppwriteAuth.createUser method to sign up the user
                    await AppwriteAuth.createUser(
                        firstname, lastname, username, email, password);

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
                  } catch (error) {
                    // If there was an error, show an error snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error creating account: $error')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
