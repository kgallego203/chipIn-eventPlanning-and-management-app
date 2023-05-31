import 'package:chip_in/features/auth/controller/auth_controller.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  final _loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _loginController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _loginController.emailController,
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
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _loginController.passwordController,
              obscureText: true,
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Login'),
              style: ElevatedButton.styleFrom(
                primary: Pallete
                    .primary100, // Set the background color of the button to primary100 from the Pallete class
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () async {
                if (_loginController.formKey.currentState != null &&
                    _loginController.formKey.currentState!.validate()) {
                  await _loginController.login(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
