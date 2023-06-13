import 'package:flutter/material.dart';
import '../features/auth/view/authentication_screen.dart';
import '/themes/theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chipIn',
      theme: ThemeData(
        // Set the primary color to Pallete.primary100
        primaryColor: Palette.primary100,
        // Set the color scheme to use Pallete.primary200 as the secondary color and Pallete.primary300 as the background color
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Palette.primary200,
              background: Palette.primary300,
            ),
        // Set the app bar theme to use Pallete.primary300 as the background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.primary300,
        ),
      ),
      // Set the home screen to be the AuthenticationScreen widget
      home: AuthenticationScreen(),
    );
  }
}
