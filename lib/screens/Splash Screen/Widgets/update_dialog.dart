import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateDialog extends StatelessWidget {
  final String updateUrl;
  const UpdateDialog({super.key, required this.updateUrl});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: const Color(0xFF0F131E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFF00F0FF), width: 1.5),
        ),
        title: Row(
          children: [
            const Icon(Icons.system_update_rounded, color: Color(0xFF00F0FF)),
            const SizedBox(width: 12),
            Text(
              "Update Required",
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
              "A newer version of Guess Duel is available. Please update the app to continue playing.",
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 15,
              ),
            ),
            if (updateUrl.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                "Update Link:",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              SelectableText(
                updateUrl,
                style: GoogleFonts.spaceGrotesk(
                  color: const Color(0xFF00F0FF),
                  fontSize: 13,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ],
        ),
        actions: [
          if (updateUrl.isNotEmpty)
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: updateUrl));
                Get.snackbar("Copied", "Update URL copied to clipboard");
              },
              child: Text(
                "COPY LINK",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          TextButton(
            onPressed: () {
              if (updateUrl.isNotEmpty) {
                Clipboard.setData(ClipboardData(text: updateUrl));
              }
              SystemNavigator.pop();
            },
            child: Text(
              "EXIT",
              style: GoogleFonts.spaceGrotesk(
                color: const Color(0xFF00F0FF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
