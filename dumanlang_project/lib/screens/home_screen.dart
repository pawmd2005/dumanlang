import 'package:flutter/material.dart';
import '../widgets/app_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HerbaVision'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Open Login'),
            ),
            const SizedBox(height: 16),
            AppButton(
              text: 'Open Report Form',
              onPressed: () {
                Navigator.pushNamed(context, '/report');
              },
            ),
          ],
        ),
      ),
    );
  }
}