import 'package:chip_in/features/auth/controller/auth_controller.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  // Create an instance of the LoginController class by assigning it to the loginController variable
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: loginController
            .formKey, // The instance of the LoginController() can invoke the formKey instance of the GlobalKey<FormState> class
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Email Field
            TextFormField(
              controller: loginController
                  .emailController, // User's email input will be stored here
              decoration: InputDecoration(
                hintText: 'Email',
                fillColor: Pallete.neutral10,
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
                return null;
              },
            ),

            const SizedBox(height: 16),

            // Password Field
            TextFormField(
              controller: loginController
                  .passwordController, // User's password input will be stored here
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
