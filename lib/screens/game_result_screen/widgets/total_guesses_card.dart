import 'dart:ui';
import 'package:flutter/material.dart';
import '../game_result_screen.dart';

class TotalGuessesCard extends StatelessWidget {
  final int totalGuesses;

  const TotalGuessesCard({
    super.key,
    required this.totalGuesses,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Total Guesses',
                style: TextStyle(
                  fontFamily: 'Plus Jakarta Sans',
                  fontSize: 12,
                  letterSpacing: 1.5,
                  color: Color(0xFFB3B0AD),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                totalGuesses.toString(),
                style: const TextStyle(
                  fontFamily: 'Space Grotesk',
                  fontSize: 56,
                  fontWeight: FontWeight.w800,
                  color: GameResultScreen.onSurface,
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
