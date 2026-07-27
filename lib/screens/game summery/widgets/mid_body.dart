import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsContainer extends StatelessWidget {
  final int attempts;
  final int accuracy;
  const StatsContainer({
    super.key,
    required this.attempts,
    required this.accuracy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 120,

                decoration: BoxDecoration(
                  color: const Color(0xFF201F1F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "# Attempts",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        attempts.toString(),
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: Container(
                height: 120,

                decoration: BoxDecoration(
                  color: const Color(0xFF201F1F),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  child: Column(
                    children: [
                      Text(
                        "# Accuracy",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "$accuracy%",
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
