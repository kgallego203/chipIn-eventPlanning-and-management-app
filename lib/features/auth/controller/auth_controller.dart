import 'package:flutter/material.dart';
import 'package:chip_in/services/auth_service.dart';

class LoginController {
  // Define TextEditingController objects for the email and password fields
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  Future<void> login(BuildContext context) async {
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
}

class SignUpController {
  // Define TextEditingController objects for the form fields
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  Future<void> signUp(BuildContext context) async {
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
}
