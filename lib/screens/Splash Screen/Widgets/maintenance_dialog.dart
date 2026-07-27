import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenanceDialog extends StatelessWidget {
  const MaintenanceDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: const Color(0xFF0F131E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFFDAB9FF), width: 1.5),
        ),
        title: Row(
          children: [
            const Icon(Icons.build_rounded, color: Color(0xFFDAB9FF)),
            const SizedBox(width: 12),
            Text(
              "Maintenance",
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          "Guess Duel is currently undergoing scheduled maintenance. Please try again later.",
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text(
              "EXIT GAME",
              style: GoogleFonts.spaceGrotesk(
                color: const Color(0xFFDAB9FF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
