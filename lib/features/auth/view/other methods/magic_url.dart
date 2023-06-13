import 'package:chip_in/features/auth/services/user_service.dart';
import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';

class MagicUrlScreen extends StatelessWidget {
  MagicUrlScreen({super.key});
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Magic URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: userIdController,
              decoration: InputDecoration(
                hintText: 'User ID',
                prefixIcon: const Icon(
                  Icons.person,
                  color: Palette.primary100,
                ),
                fillColor: Palette.neutral10,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(
                  Icons.email,
                  color: Palette.primary100,
                ),
                fillColor: Palette.neutral10,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String userId = userIdController.text;
                String email = emailController.text;
                await UserService.sendMagicURL(userId, email);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.primary100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Text(
                  'Generate Magic URL',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
