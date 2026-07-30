import 'package:flutter/material.dart';
import 'package:guess_duel/theme/solo_challenge_theme.dart';

class FeedbackLegend extends StatelessWidget {
  const FeedbackLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendChip(
          color: Colors.green,
          shadowColor: const Color(0xFFDAB9FF),
          label: 'CORRECT',
          textColor: Colors.green,
        ),
        _buildLegendChip(
          color: SoloChallengeTheme.secondaryContainer,
          shadowColor: const Color(0xFF00EEFC),
          label: 'POSITIONED',
          textColor: SoloChallengeTheme.secondary,
        ),
      ],
    );
  }

  Widget _buildLegendChip({
    required Color color,
    required Color shadowColor,
    required String label,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: SoloChallengeTheme.surfaceContainerHighest.withValues(
          alpha: 0.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withValues(alpha: 0.8),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: SoloChallengeTheme.labelStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.2,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
