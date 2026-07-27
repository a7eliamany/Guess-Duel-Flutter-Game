import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInHeader extends StatelessWidget {
  const SignInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Central brain/psychology logo container with premium glow
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF00E5FF).withValues(alpha: 0.1),
            border: Border.all(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.15),
                blurRadius: 30,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.psychology,
            color: Color(0xFF00E5FF),
            size: 50,
          ),
        ),
        const SizedBox(height: 16),
        // Title with text-shadow glow
        Text(
          "Guess Duel",
          style: GoogleFonts.manrope(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -1.0,
            height: 1.1,
            shadows: [
              Shadow(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.4),
                blurRadius: 10,
              ),
              Shadow(
                color: const Color(0xFF00E5FF).withValues(alpha: 0.2),
                blurRadius: 20,
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        // Subtitle tagline
        Text(
          "Enter the arena of intuition.",
          style: GoogleFonts.inter(
            fontSize: 16,
            color: const Color(0xFFBAC9CC),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
