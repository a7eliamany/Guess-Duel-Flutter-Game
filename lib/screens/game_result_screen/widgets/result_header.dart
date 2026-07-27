import 'package:flutter/material.dart';
import '../game_result_screen.dart';

class ResultHeader extends StatelessWidget {
  final bool isWin;

  const ResultHeader({
    super.key,
    required this.isWin,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      isWin ? "Win" : "Lose",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontFamily: 'Space Grotesk',
        fontSize: 56,
        fontWeight: FontWeight.w800,
        letterSpacing: -1.5,
        color: isWin ? GameResultScreen.tertiary : Colors.red[500],
        shadows: [
          Shadow(
            blurRadius: 20,
            color: isWin
                ? const Color(0xFFA9FFAC)
                : Colors.red[200]!,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }
}
