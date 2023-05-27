// Import the necessary packages and files
import 'package:chip_in/services/auth_service.dart';
import 'package:flutter/material.dart';

/* The code defines a LoginWidget class that creates a login form with email and 
password text fields and a login button. The form is validated using a GlobalKey<FormState> 
object and the TextEditingController objects are disposed of when the widget is disposed. 
When the login button is pressed, the email and password are retrieved from the text fields 
and passed to the AppwriteAuth.createSession method to log in the user. If successful, a 
success snackbar is shown, and if there was an error, an error snackbar is shown. */

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
              onPressed: () async {
                // Check if the form is valid
                if (_formKey.currentState != null &&
                    _formKey.currentState!.validate()) {
                  // Get the email and password from the text fields
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  try {
                    // Call the AppwriteAuth.createSession method to log in the user
                    await AppwriteAuth.createSession(context, email, password);
                    // If successful, show a success snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logged in successfully')),
                    );
                  } catch (error) {
                    // If there was an error, show an error snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error logging in: $error')),
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
