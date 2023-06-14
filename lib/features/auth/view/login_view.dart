import 'package:chip_in/features/auth/controller/auth_controller.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';

// Defining a stateless widget called LoginView
class LoginView extends StatelessWidget {
  // Create an instance of the LoginController class by assigning it to the loginController variable
  final loginController = LoginController();

  // Build method that returns a widget tree
  @override
  Widget build(BuildContext context) {
    // Returns a Padding widget with a Form widget as its child
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        // Assigning the formKey instance of the GlobalKey<FormState> class to the formKey instance of the LoginController() class
        key: loginController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email Field
            TextFormField(
              // Assigning the emailController instance of the TextEditingController class to the controller instance of the TextFormField class
              controller: loginController.emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Pallete.neutral10,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              // Validator function that checks if the value is null or empty
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Password Field
            TextFormField(
              // Assigning the passwordController instance of the TextEditingController class to the controller instance of the TextFormField class
              controller: loginController.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Pallete.neutral10,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              // Validator function that checks if the value is null or empty
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Login Button
            ElevatedButton(
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.primary100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              // Asynchronous function that checks if the form is valid and logs the user in
              onPressed: () async {
                if (loginController.formKey.currentState != null &&
                    loginController.formKey.currentState!.validate()) {
                  await loginController.login(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
