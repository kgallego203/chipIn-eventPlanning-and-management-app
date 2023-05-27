import 'package:chip_in/app_colors.dart';
import 'package:flutter/material.dart';
import 'authentication_screen/authentication_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chipIn',
      theme: ThemeData(
        primaryColor: AppColors.appwritePink,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: AppColors.appwriteDarkPink,
              background: AppColors.appwriteLightPink,
            ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.appwriteDarkPink,
        ),
      ),
      home: AuthenticationScreen(),
    );
  }
}
