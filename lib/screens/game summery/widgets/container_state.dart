import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:remixicon/remixicon.dart';

/// Result Hero Section — shows win/loss badge, title, date, and attempt count.
class ResultHeroSection extends StatelessWidget {
  final bool isWin;
  final DateTime dateTime;
  final int attemptCount;
  final int accuracy;
  final String secretCode;

  const ResultHeroSection({
    super.key,
    required this.isWin,
    required this.dateTime,
    required this.attemptCount,
    required this.accuracy,
    required this.secretCode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          // Trophy / X badge with glow
          _buildBadge(),
          const SizedBox(height: 16),

          // Victory / Defeat text
          Text(
            isWin ? 'VICTORY!' : 'DEFEAT!',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFDAB9FF),
              letterSpacing: -1.2,
            ),
          ),
          const SizedBox(height: 4),

          // Date
          Text(
            DateFormat.yMMMMd().format(dateTime),
            style: GoogleFonts.manrope(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: const Color(0xFFCFC2D9),
            ),
          ),
          const SizedBox(height: 24),

          // Attempts stat
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    attemptCount.toString(),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD3FBFF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ATTEMPTS',
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFCFC2D9),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),

              Column(
                children: [
                  Text(
                    '${accuracy.toString()}%',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD3FBFF),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'ACCURACY',
                    style: GoogleFonts.manrope(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFCFC2D9),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),

          Column(
            children: [
              Text(
                secretCode,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFD3FBFF),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Secret Code',
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFCFC2D9),
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBadge() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow effect behind the badge
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: isWin
                    ? const Color(0xFFDAB9FF).withValues(alpha: 0.3)
                    : const Color(0xFFFFB4AB).withValues(alpha: 0.3),
                blurRadius: 25,
                spreadRadius: 5,
              ),
            ],
          ),
        ),
        // Badge Square
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            color: isWin ? const Color(0xFF8F00FF) : const Color(0xFF93000A),
            border: Border.all(
              color: isWin
                  ? const Color(0xFFDAB9FF).withValues(alpha: 0.3)
                  : const Color(0xFFFFB4AB).withValues(alpha: 0.3),
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: isWin
                    ? const Color(0xFFDAB9FF).withValues(alpha: 0.3)
                    : const Color(0xFFFFB4AB).withValues(alpha: 0.3),
                blurRadius: 15,
              ),
            ],
          ),
          child: Icon(
            isWin ? RemixIcons.trophy_fill : RemixIcons.skull_2_fill,
            size: 40,
            color: isWin ? const Color(0xFFEFDDFF) : const Color(0xFFFFDAD6),
          ),
        ),
      ],
    );
  }
}
