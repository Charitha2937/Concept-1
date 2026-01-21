import 'package:flutter/material.dart';

class CongratulationsScreen extends StatelessWidget {
  const CongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: Center(
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.3,
            ),
            children: [
              TextSpan(text: 'Congrats\nYou\nCompleted\nToday\'s\nTask\n'),
              TextSpan(
                text: '🤗🤗🤗',
                style: TextStyle(fontSize: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
