import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessStatusHeader extends StatelessWidget {
  const SuccessStatusHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background SUCCESS watermark text
          Opacity(
            opacity: 0.10,
            child: Text(
              'SUCCESS',
              style: GoogleFonts.spaceGrotesk(
                fontSize: MediaQuery.of(context).size.width > 500 ? 100 : 85,
                fontWeight: FontWeight.w900,
                color: const Color(0xFF78F186),
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
                'SECURITY PROTOCOL BYPASSED',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFF78F186).withValues(alpha: 0.7),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'CHALLENGE SUCCESSED',
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFF78F186),
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
