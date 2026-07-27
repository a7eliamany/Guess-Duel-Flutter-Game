import 'package:flutter/material.dart';

class HistoryTitle extends StatelessWidget {
  const HistoryTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Attempt History',
          style: TextStyle(
            color: Color(0xFF767575),
            fontSize: 10,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
