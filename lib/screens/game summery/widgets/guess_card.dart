import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Widgets/glass_card.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';

/// Timeline-style attempt card for the guess history.
class GuessCard extends StatelessWidget {
  final int index;
  final AttemptModel attemptModel;
  final bool isGuessCorrect;
  final int digitsCount;

  const GuessCard({
    super.key,
    required this.index,
    required this.attemptModel,
    required this.isGuessCorrect,
    required this.digitsCount,
  });

  @override
  Widget build(BuildContext context) {
    final correct = attemptModel.correctPlaces;
    final exist = attemptModel.correctNumbers - correct;
    final wrong = digitsCount - (correct + exist);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline circle indicator
          _buildCircleIndicator(),
          const SizedBox(width: 16),
          // Attempt card
          Expanded(child: _buildCard(correct, exist, wrong)),
        ],
      ),
    );
  }

  Widget _buildCircleIndicator() {
    if (isGuessCorrect) {
      // Winning guess — primary colored circle with check icon
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFDAB9FF),
          border: Border.all(color: const Color(0xFF131313), width: 2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFDAB9FF).withValues(alpha: 0.3),
              blurRadius: 12,
            ),
          ],
        ),
        child: const Icon(Icons.check, color: Color(0xFF470083), size: 24),
      );
    }

    // Normal attempt — dark circle with number
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF2A2A2A),
        border: Border.all(color: const Color(0xFF131313), width: 2),
      ),
      child: Center(
        child: Text(
          index.toString(),
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: const Color(0xFFCFC2D9),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(int correct, int exist, int wrong) {
    if (isGuessCorrect) {
      // Winning guess gets a glass card with primary border
      return GlassCard(
        borderColor: const Color(0xFFDAB9FF).withValues(alpha: 0.2),
        padding: const EdgeInsets.all(16),
        child: _buildCardContent(correct, exist, wrong),
      );
    }

    // Normal attempt card
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1B1B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF4D4356).withValues(alpha: 0.1),
        ),
      ),
      child: _buildCardContent(correct, exist, wrong),
    );
  }

  Widget _buildCardContent(int correct, int exist, int wrong) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ATTEMPT $index',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: isGuessCorrect
                    ? const Color(0xFFDAB9FF)
                    : const Color(0xFFCFC2D9),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Guess digits + result squares
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Guess number with letter spacing
            Text(
              attemptModel.attempt,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 8,
                color: isGuessCorrect
                    ? Colors.white
                    : const Color(0xFFE5E2E1).withValues(alpha: 0.8),
              ),
            ),
            // Result squares
            Row(
              children: [
                _buildBadge(
                  count: attemptModel.correctNumbers,
                  bgColor: Colors.green,
                  textColor: Colors.white,
                ),
                const SizedBox(width: 8),
                _buildBadge(
                  count: attemptModel.correctPlaces,
                  bgColor: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBadge({
    required int count,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(2),
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}

enum GuessState { correct, exist, wrong }

class ResultSquare extends StatelessWidget {
  final GuessState state;
  const ResultSquare({super.key, required this.state});

  Color get color {
    switch (state) {
      case GuessState.correct:
        return const Color(0xFF22C55E);
      case GuessState.exist:
        return const Color(0xFFEAB308);
      case GuessState.wrong:
        return const Color(0xFF4B5563);
    }
  }

  List<BoxShadow>? get shadow {
    if (state == GuessState.correct) {
      return [
        BoxShadow(
          color: const Color(0xFF22C55E).withValues(alpha: 0.2),
          blurRadius: 8,
        ),
      ];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
        boxShadow: shadow,
      ),
    );
  }
}
