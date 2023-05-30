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
        primaryColor: Pallete.primary100,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: Pallete.primary200,
              background: Pallete.primary300,
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.primary300,
        ),
      ),
      home: AuthenticationScreen(),
    );
  }
}
