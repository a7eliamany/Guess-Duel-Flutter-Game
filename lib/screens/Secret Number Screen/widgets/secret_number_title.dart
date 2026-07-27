import 'package:flutter/material.dart';

class SecretNumberTitle extends StatelessWidget {
  const SecretNumberTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Enter Your Secret Number',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE5E2E1),
            fontFamily: 'Manrope',
          ),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: 8),

        Text(
          'Choose a 4-digit combination',
          style: TextStyle(
            color: Color(0xFF849396),
            fontSize: 14,
            fontFamily: 'Inter',
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
