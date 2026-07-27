import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class AppDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required IconData icon,
    required Color accentColor,
    required List<Widget> actions,
    bool? canPop,
    Widget? extraContent,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: canPop ?? false,
      builder: (context) {
        return PopScope(
          canPop: canPop ?? false,
          child: AlertDialog(
            backgroundColor: const Color(0xFF0F131E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: BorderSide(color: accentColor, width: 1.5),
            ),
            title: Row(
              children: [
                Icon(icon, color: accentColor),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message,
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 15,
                  ),
                ),
                if (extraContent != null) ...[
                  const SizedBox(height: 16),
                  extraContent,
                ],
              ],
            ),
            actions: actions,
          ),
        );
      },
    );
  }
}
