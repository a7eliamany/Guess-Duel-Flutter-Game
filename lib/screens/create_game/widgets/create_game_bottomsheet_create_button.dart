import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/Widgets/scale_on_press_button.dart';

class CreateGameBottomsheetCreateButton extends StatelessWidget {
  final bool isLoading;

  final void Function()? onPressed;

  const CreateGameBottomsheetCreateButton({
    super.key,
    required this.isLoading,

    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleOnPressButton(
      onPressed: onPressed,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFC3F5FF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFC3F5FF).withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF00363D),
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.sports_esports,
                      color: Color(0xFF00363D),
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Create Room",
                      style: GoogleFonts.manrope(
                        color: const Color(0xFF00363D),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
