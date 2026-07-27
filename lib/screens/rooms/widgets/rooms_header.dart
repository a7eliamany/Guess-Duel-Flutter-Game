import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomsHeader extends StatelessWidget {
  const RoomsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Live Lobbies',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFd4bbff),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Find Your Match',
          style: GoogleFonts.manrope(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: const Color(0xFFe5e2e1),
          ),
        ),
        Container(
          width: 48,
          height: 4,
          color: const Color(0xFFc3f5ff),
          margin: const EdgeInsets.only(top: 16),
        ),
      ],
    );
  }
}
