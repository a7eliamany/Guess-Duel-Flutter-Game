import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

/// The brand header featuring the Guess Duel glowing emblem,
/// stylized gradient title, and subtitle.
class AuthBrandHeader extends StatelessWidget {
  final String subtitle;

  const AuthBrandHeader({
    super.key,
    this.subtitle = 'Create Your Account to Sync Your Stats!',
  });

  static const String _duelEmblemPng = 'assets/images/icons8-numbers-64.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Brand Emblem with outer glow
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Gradient Border Frame
              SizedBox(
                    width: double.infinity,
                    height: 90,
                    child: Image.asset(
                      _duelEmblemPng,
                      fit: BoxFit.contain,
                      height: 90,
                      width: 90,
                    ),
                  )
                  .animate()
                  .slideX(duration: 550.ms, begin: -0.1, end: 0)
                  .fadeIn(duration: 300.milliseconds),
            ],
          ),
        ),

        const SizedBox(height: 4),

        // Brand Title "Guess Duel"
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Guess',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(width: 4),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00F0FF), Color(0xFFB060FF)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds),
              child: Text(
                'Duel',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        // Subtitle
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            color: const Color(0xFF94A3B8),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
