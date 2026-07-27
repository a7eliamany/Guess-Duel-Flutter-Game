import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateGameBottomsheetCancelButton extends StatelessWidget {
  const CreateGameBottomsheetCancelButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          "CANCEL",
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF849396),
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
