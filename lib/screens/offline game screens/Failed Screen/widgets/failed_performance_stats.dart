import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Functions/game_utils.dart';

class FailedPerformanceStats extends StatelessWidget {
  final int attemptsUsed;
  final int maxAttempts;
  final int totalTimeInSeconds;
  final int timeTakenInSeconds;

  const FailedPerformanceStats({
    super.key,

    this.maxAttempts = 10,

    this.totalTimeInSeconds = 600,
    this.timeTakenInSeconds = 200,
    this.attemptsUsed = 1,
  });

  @override
  Widget build(BuildContext context) {
    final attemptsFraction = maxAttempts > 0
        ? (attemptsUsed / maxAttempts).clamp(0.0, 1.0)
        : 1.0;

    final timeFraction = totalTimeInSeconds > 0
        ? (timeTakenInSeconds / totalTimeInSeconds).clamp(0.0, 1.0)
        : 1.0;

    return Row(
      children: [
        // Attempts Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF201F1F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -16,
                  right: -16,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB4AB).withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ATTEMPTS Used',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFFCFC2D9),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$attemptsUsed',
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFFE5E2E1),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '/ $maxAttempts',
                          style: GoogleFonts.manrope(
                            color: const Color(0xFF988CA2),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Progress bar
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF353534),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: attemptsFraction,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFB4AB),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Duration Card
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF201F1F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -16,
                  right: -16,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00EEFC).withValues(alpha: 0.05),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DURATION',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFFCFC2D9),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          GameUtils.getTime(timeTakenInSeconds),
                          style: GoogleFonts.spaceGrotesk(
                            color: const Color(0xFFE5E2E1),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (totalTimeInSeconds > 0)
                          Text(
                            ' / ${GameUtils.getTime(totalTimeInSeconds)}',
                            style: GoogleFonts.spaceGrotesk(
                              color: const Color(0xFFE5E2E1),
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Progress bar
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF353534),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: timeFraction,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF00EEFC,
                            ).withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
