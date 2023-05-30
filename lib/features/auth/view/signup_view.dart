import 'package:chip_in/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  final _signUpController = SignUpController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _signUpController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _signUpController.firstNameController,
              decoration: const InputDecoration(hintText: 'First Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _signUpController.lastNameController,
              decoration: const InputDecoration(hintText: 'Last Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _signUpController.emailController,
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
            TextFormField(
              controller: _signUpController.usernameController,
              decoration: const InputDecoration(hintText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _signUpController.passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a password';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _signUpController.confirmPasswordController,
              decoration: const InputDecoration(hintText: 'Confirm Password'),
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
            ElevatedButton(
              child: const Text('Sign Up'),
              onPressed: () async {
                if (_signUpController.formKey.currentState != null &&
                    _signUpController.formKey.currentState!.validate()) {
                  await _signUpController.signUp(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
