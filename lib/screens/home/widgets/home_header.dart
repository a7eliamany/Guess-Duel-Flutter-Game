import 'package:flutter/material.dart';
import 'package:guess_duel/Widgets/text.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Guess Duel",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 48,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: const Color(0xff8FF5FF).withValues(alpha: 0.5),
                blurRadius: 20,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
        CText(
          data: "Enter the void. Break the sequence.",
          size: 16,
          color: Colors.white.withValues(alpha: 0.7),
        ),
      ],
    );
  }
}
