import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateGameBottomsheetHeader extends StatelessWidget {
  const CreateGameBottomsheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Create Room",
          style: GoogleFonts.manrope(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE5E2E1),
            height: 1.1,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Create a room and invite your friends to play.",
          style: GoogleFonts.inter(
            fontSize: 16,
            color: const Color(0xFFBAC9CC),
          ),
        ),
      ],
    );
  }
}
