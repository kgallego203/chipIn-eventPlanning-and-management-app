import 'package:chip_in/features/auth/controller/auth_controller.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  final _signUpController = SignUpController();

  @override
  Widget build(BuildContext context) {
    // A form with several text form fields for the user to enter their information
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _signUpController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text form field for the user's first name
            TextFormField(
              controller: _signUpController.firstNameController,
              decoration: InputDecoration(
                hintText: 'First Name',
                fillColor: Pallete
                    .neutral10, // Set the fill color of the text field to neutral10 from the Pallete class
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Text form field for the user's last name
            TextFormField(
              controller: _signUpController.lastNameController,
              decoration: InputDecoration(
                hintText: 'Last Name',
                fillColor: Pallete
                    .neutral10, // Set the fill color of the text field to neutral10 from the Pallete class
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Text form field for the user's email address
            TextFormField(
              controller: _signUpController.emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Pallete
                    .neutral10, // Set the fill color of the text field to neutral10 from the Pallete class
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
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
            const SizedBox(height: 16),
            // Text form field for the user's desired username
            TextFormField(
              controller: _signUpController.usernameController,
              decoration: InputDecoration(
                hintText: 'Username',
                fillColor: Pallete
                    .neutral10, // Set the fill color of the text field to neutral10 from the Pallete class
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Text form field for the user's desired password
            TextFormField(
              controller: _signUpController.passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Pallete
                    .neutral10, // Set the fill color of the text field to neutral10 from the Pallete class
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Text form field to confirm the user's desired password
            TextFormField(
              controller: _signUpController.confirmPasswordController,
              decoration: InputDecoration(
                hintText: 'Confirm Password',
                fillColor: Pallete
                    .neutral10, // Set the fill color of the text field to neutral10 from the Pallete class
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != _signUpController.passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Button to submit the form and sign up the user
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete
                    .primary100, // Set the background color of the button to primary100 from the Pallete class
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Sign Up'),
              onPressed: () async {
                if (_signUpController.formKey.currentState != null &&
                    _signUpController.formKey.currentState!.validate()) {
                  await _signUpController.signUp(
                      context); // If it's true, it will trigger the .signUp method from the SignUpController class
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
