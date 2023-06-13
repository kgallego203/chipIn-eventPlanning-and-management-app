import 'package:chip_in/themes/palette.dart';
import 'package:flutter/material.dart';

class MagicUrlScreen extends StatelessWidget {
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
                  color: Pallete.primary100,
                ),
                fillColor: Pallete.neutral10,
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
                  color: Pallete.primary100,
                ),
                fillColor: Pallete.neutral10,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Call your magic URL method here, passing the user ID and email
                // e.g., UserService.createMagicURL(context, userIdController.text, emailController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Pallete.primary100,
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
