import 'package:flutter/material.dart';

class EndOfRecords extends StatelessWidget {
  const EndOfRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 16),
      child: Opacity(
        opacity: 0.2,
        child: Column(
          children: [
            Icon(
              Icons.history_edu_rounded,
              size: 48,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            const SizedBox(height: 8),
            Text(
              'END OF RECORDS',
              style: TextStyle(
                fontFamily: 'Space Grotesk',
                fontSize: 9,
                fontWeight: FontWeight.w600,
                letterSpacing: 3.0,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
