import 'package:flutter/material.dart';
import '../game_result_screen.dart';

class OpponentCodeCard extends StatelessWidget {
  final String opponentSecretCode;

  const OpponentCodeCard({
    super.key,
    required this.opponentSecretCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: GameResultScreen.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            'your opponent number was',
            style: TextStyle(
              fontFamily: 'Plus Jakarta Sans',
              fontSize: 12,
              letterSpacing: 2,
              color: Color(0xFFB3B0AD),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            opponentSecretCode,
            style: const TextStyle(
              fontFamily: 'Space Grotesk',
              fontSize: 42,
              fontWeight: FontWeight.w800,
              letterSpacing: 4,
              color: GameResultScreen.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
