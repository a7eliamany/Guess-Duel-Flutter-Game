import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailedActionSuite extends StatelessWidget {
  final VoidCallback? onRetryPressed;
  final VoidCallback? onModifyDifficultyPressed;

  const FailedActionSuite({
    super.key,
    this.onRetryPressed,
    this.onModifyDifficultyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Initiate Retry Button
        InkWell(
          onTap: onRetryPressed,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF8F00FF), Color(0xFFDAB9FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'RETRY',
                      style: GoogleFonts.spaceGrotesk(
                        color: const Color(0xFF470083),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  right: 16,
                  child: Opacity(
                    opacity: 0.40,
                    child: Icon(
                      Icons.refresh,
                      color: Color(0xFF470083),
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Modify Difficulty Button
        InkWell(
          onTap: onModifyDifficultyPressed,
          borderRadius: BorderRadius.circular(4),
          child: Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF353534),
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              'MODIFY DIFFICULTY',
              style: GoogleFonts.spaceGrotesk(
                color: const Color(0xFFE5E2E1),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
