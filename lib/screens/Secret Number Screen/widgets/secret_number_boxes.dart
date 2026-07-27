import 'package:flutter/material.dart';
import 'package:guess_duel/cubit/Secret%20number/secret_number_state.dart';

class SecretNumberBoxes extends StatelessWidget {
  final SecretNumberState state;
  const SecretNumberBoxes({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (i) {
        String display = i < state.digits.length
            ? state.digits[i]
            : ''.isEmpty
            ? (i == state.currentIndex ? '|' : '')
            : state.digits[i];

        Color borderColor = i == state.currentIndex
            ? const Color(0xFFC3F5FF)
            : const Color(0xFF3B494C).withValues(alpha: 0.3);

        Color textColor = i == state.currentIndex
            ? const Color(0xFFC3F5FF)
            : const Color(0xFFE5E2E1);

        return Container(
          width: 64,
          height: 80,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFF0E0E0E),
            borderRadius: BorderRadius.circular(12),
            border: Border(bottom: BorderSide(color: borderColor, width: 2)),
          ),
          child: Text(
            display,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: textColor,
              fontFamily: 'Manrope',
            ),
          ),
        );
      }),
    );
  }
}
