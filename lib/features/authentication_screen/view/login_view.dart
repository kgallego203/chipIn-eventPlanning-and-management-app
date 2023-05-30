import 'package:chip_in/features/authentication_screen/controller/auth_controller.dart';
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
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _loginController.passwordController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            ElevatedButton(
              child: const Text('Login'),
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
