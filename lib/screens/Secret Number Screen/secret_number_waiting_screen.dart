import 'package:flutter/material.dart';

class SecretNumberWaitingScreen extends StatelessWidget {
  const SecretNumberWaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFC3F5FF)),
              strokeWidth: 4,
            ),
          ),

          SizedBox(height: 40),

          Text(
            'Waiting for others...',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE5E2E1),
              fontFamily: 'Manrope',
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12),

          Text(
            'The duel begins once your opponent has set their number.',
            style: TextStyle(
              color: Color(0xFF849396),
              fontSize: 14,
              fontFamily: 'Inter',
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
