import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Performance Insights card with accuracy and speed progress bars.
class PerformanceInsights extends StatelessWidget {
  final int accuracy;
  final int attempts;

  const PerformanceInsights({
    super.key,
    required this.accuracy,
    required this.attempts,
  });

  /// Speed score: fewer attempts = higher speed.
  /// Max is 7 attempts — 1 attempt = 100%, 7+ = ~14%.
  double get speedScore {
    if (attempts <= 0) return 0;
    return ((7 - attempts.clamp(1, 7) + 1) / 7 * 100).clamp(0, 100);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF201F1F),
            Color(0xFF1C1B1B),
          ],
        ),
        border: Border.all(
          color: const Color(0xFF4D4356).withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              const Icon(
                Icons.analytics_outlined,
                size: 16,
                color: Color(0xFFD3FBFF),
              ),
              const SizedBox(width: 8),
              Text(
                'PERFORMANCE INSIGHTS',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  color: const Color(0xFFCFC2D9),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Accuracy bar
          _buildProgressBar(
            label: 'ACCURACY',
            value: accuracy / 100,
            barColor: const Color(0xFFDAB9FF),
            glowColor: const Color(0xFFDAB9FF).withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),

          // Speed bar
          _buildProgressBar(
            label: 'SPEED',
            value: speedScore / 100,
            barColor: const Color(0xFFD3FBFF),
            glowColor: const Color(0xFF00EEFC).withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar({
    required String label,
    required double value,
    required Color barColor,
    required Color glowColor,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: GoogleFonts.manrope(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFCFC2D9),
              letterSpacing: 1.0,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: const Color(0xFF353534),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: barColor,
                  boxShadow: [
                    BoxShadow(
                      color: glowColor,
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
