import 'package:flutter/material.dart';
import '../screens/authentication_screen/authentication_screen.dart';
import '/themes/theme.dart';

// Import the Appwrite palette
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable the debug banner
      debugShowCheckedModeBanner: false,
      // Set the app title
      title: 'chipIn',
      // Set the app theme
      theme: ThemeData(
        // Set the primary color to Appwrite pink
        primaryColor: Pallete.primary100,
        // Set the color scheme
        colorScheme: ThemeData().colorScheme.copyWith(
              // Set the secondary color to Appwrite dark pink
              secondary: Pallete.primary200,
              // Set the background color to Appwrite light pink
              background: Pallete.primary300,
            ),
        // Set the app bar theme
        appBarTheme: AppBarTheme(
          // Set the app bar background color to Appwrite dark pink
          backgroundColor: Pallete.primary300,
        ),
      ),
      // Set the home screen to the authentication screen
      home: AuthenticationScreen(),
    );
  }
}
