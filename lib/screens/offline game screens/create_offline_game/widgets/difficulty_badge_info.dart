import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DifficultyBadgeInfo extends StatelessWidget {
  final IconData icon;
  final String label;

  const DifficultyBadgeInfo({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(0xFFCFC2D9),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFFCFC2D9),
          ),
        ),
      ],
    );
  }
}
