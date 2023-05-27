import 'package:chip_in/app_colors.dart';
import 'package:flutter/material.dart';
import 'screens/authentication_screen/authentication_screen.dart';

void main() {
  runApp(MyApp());
}

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
        primaryColor: AppColors.appwritePink,
        // Set the color scheme
        colorScheme: ThemeData().colorScheme.copyWith(
              // Set the secondary color to Appwrite dark pink
              secondary: AppColors.appwriteDarkPink,
              // Set the background color to Appwrite light pink
              background: AppColors.appwriteLightPink,
            ),
        // Set the app bar theme
        appBarTheme: const AppBarTheme(
          // Set the app bar background color to Appwrite dark pink
          backgroundColor: AppColors.appwriteDarkPink,
        ),
      ),
      // Set the home screen to the authentication screen
      home: AuthenticationScreen(),
    );
  }
}
