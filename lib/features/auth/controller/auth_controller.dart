import 'package:chip_in/features/home/home_screen.dart';
import 'package:chip_in/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:chip_in/features/auth/services/auth_service.dart';

class LoginController {
  // Define GlobalKey<FormState> object for the form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Define TextEditingController objects for the email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // This function is responsible for logging in the user by calling the AppwriteAuth.createSession method with the email and password entered by the user.
  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      // Call the AppwriteAuth.createSession method to log in the user
      await AppwriteAuth.createSession(context, email, password);

      // Navigate to HomePage after successful login
      // This is possible because the context parameter is passed to the createSession method
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );

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

// todo: add a navigator that after signup, it will route the user to the hompage
class SignUpController {
  // Define GlobalKey<FormState> object for the form key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Define TextEditingController objects for the form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  Future<void> signUp(BuildContext context) async {
    // When the signUp is triggered in the UI, it will perform the operations below:
    // * Get the values from the form fields
    final firstname = firstNameController.text;
    final lastname = lastNameController.text;
    final email = emailController.text;
    final username = usernameController.text;
    final password = passwordController.text;

    try {
      // Now the info entered by the user is stored in the variables above.
      // * Call the AppwriteAuth.createUser method to sign up the user
      await AppwriteAuth.createUser(
          // You are passing the values of the variables in the .createUser method to be used in the auth_service.dart file
          firstname,
          lastname,
          username,
          email,
          password);

      // * Clear the form fields after sign up success
      firstNameController.text = '';
      lastNameController.text = '';
      emailController.text = '';
      usernameController.text = '';
      passwordController.text = '';
      confirmPasswordController.text = '';

      // * Show a snackbar to indicate that the account was created
      const snackBar = SnackBar(
        content: Text('Account Created!'),
        backgroundColor: Pallete.success200,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (error) {
      // * If there was an error, show an error snackbar
      final snackBar = SnackBar(
        content: Text('Error creating account: $error'),
        backgroundColor: Pallete.warning200,
        behavior: SnackBarBehavior.floating,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
