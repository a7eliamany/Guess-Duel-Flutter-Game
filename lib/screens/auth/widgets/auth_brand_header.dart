import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

/// The brand header featuring the Guess Duel glowing emblem,
/// stylized gradient title, and subtitle.
class AuthBrandHeader extends StatelessWidget {
  final String subtitle;

  const AuthBrandHeader({
    super.key,
    this.subtitle = 'Create Your Account to Start Dueling!',
  });

  static const String _duelEmblemSvg = '''
<svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="duelGrad" x1="10" y1="10" x2="90" y2="90" gradientUnits="userSpaceOnUse">
      <stop offset="0%" stop-color="#00F0FF"/>
      <stop offset="50%" stop-color="#7000FF"/>
      <stop offset="100%" stop-color="#FF2A85"/>
    </linearGradient>
  </defs>
  <rect x="8" y="8" width="84" height="84" rx="24" fill="#171B27" stroke="url(#duelGrad)" stroke-width="2.5"/>
  <path d="M30 70L48 52M48 52L62 38C65 35 69 35 72 38C75 41 75 45 72 48L58 62L40 80L30 80L30 70Z" fill="url(#duelGrad)" opacity="0.9"/>
  <path d="M70 70L52 52M52 52L38 38C35 35 31 35 28 38C25 41 25 45 28 48L42 62L60 80L70 80L70 70Z" fill="#00F0FF" opacity="0.8"/>
  <circle cx="50" cy="36" r="6" fill="#FFD700"/>
  <circle cx="50" cy="50" r="3" fill="#FFFFFF"/>
</svg>
''';

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
              // Outer blurred atmospheric glow
              Container(
                width: 82,
                height: 82,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00F0FF),
                      Color(0xFF7000FF),
                      Color(0xFFFF2A85),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00F0FF).withValues(alpha: 0.35),
                      blurRadius: 16,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: const Color(0xFFFF2A85).withValues(alpha: 0.25),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),

              // Gradient Border Frame
              Container(
                width: 76,
                height: 76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF00F0FF),
                      Color(0xFF7000FF),
                      Color(0xFFFF2A85),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0C101A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.string(_duelEmblemSvg, fit: BoxFit.contain),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

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
