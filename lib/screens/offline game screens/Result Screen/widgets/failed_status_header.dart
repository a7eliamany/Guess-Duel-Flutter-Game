import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailedStatusHeader extends StatelessWidget {
  const FailedStatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background FAILED watermark text
          Opacity(
            opacity: 0.10,
            child: Text(
              'FAILED',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 100,
                fontWeight: FontWeight.w900,
                color: const Color(0xFFFFB4AB),
                letterSpacing: -4,
                height: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Foreground status text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NEURAL LINK SEVERED',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFFFFB4AB),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'CHALLENGE FAILED',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFFE5E2E1),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
