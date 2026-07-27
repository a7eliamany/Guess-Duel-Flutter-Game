import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/screens/Splash%20Screen/splash_screen.dart';

class InternetDialog extends StatelessWidget {
  const InternetDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: const Color(0xFF0F131E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: Color(0xFFFF4D4D), width: 1.5),
        ),
        title: Row(
          children: [
            const Icon(Icons.wifi_off_rounded, color: Color(0xFFFF4D4D)),
            const SizedBox(width: 12),
            Text(
              "No Internet",
              style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          "No internet connection detected. Please check your network and try again.",
          style: GoogleFonts.spaceGrotesk(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 15,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              Get.offAll(() => const SplashScreen());
            },
            child: Text(
              "RETRY",
              style: GoogleFonts.spaceGrotesk(
                color: const Color(0xFFFF4D4D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: Text(
              "EXIT",
              style: GoogleFonts.spaceGrotesk(
                color: const Color(0xFFFF4D4D),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
