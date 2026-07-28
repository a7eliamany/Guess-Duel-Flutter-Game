import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TargetRevealCard extends StatelessWidget {
  final String secretCode;

  const TargetRevealCard({super.key, this.secretCode = '1234'});

  @override
  Widget build(BuildContext context) {
    final digits = secretCode.split('');

    return Stack(
      children: [
        // Ambient glow background
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: RadialGradient(
                center: Alignment.centerLeft,
                radius: 1.2,
                colors: [
                  const Color(0xFFFFB4AB).withValues(alpha: 0.20),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Reveal Card Container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              // Top-left technical marking icon
              const Positioned(
                top: 0,
                left: 0,
                child: Opacity(
                  opacity: 0.20,
                  child: Icon(
                    Icons.grid_view,
                    size: 14,
                    color: Color(0xFFE5E2E1),
                  ),
                ),
              ),
              // Bottom-right technical marking icon
              const Positioned(
                bottom: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.20,
                  child: Icon(
                    Icons.qr_code_2,
                    size: 14,
                    color: Color(0xFFE5E2E1),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,

                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'TARGET DECRYPTED',
                    style: GoogleFonts.spaceGrotesk(
                      color: const Color(0xFFCFC2D9),
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Digit cards row
                  Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        for (var digit in digits)
                          Container(
                            width: 60,
                            height: 76,
                            decoration: BoxDecoration(
                              color: const Color(0xFF353534),
                              borderRadius: BorderRadius.circular(4),
                              border: const Border(
                                top: BorderSide(
                                  color: Color(0x1AFFFFFF),
                                  width: 1,
                                ),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              digit,
                              style: GoogleFonts.spaceGrotesk(
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF00EEFC),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
