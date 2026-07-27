import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlowButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final String? loadingText;
  final Color? color;
  final Color? textColor;

  const GlowButton({
    super.key,
    required this.text,
    this.icon = Icons.play_arrow_rounded,
    this.onPressed,
    required this.isEnabled,
    this.loadingText,
    this.color = const Color(0xFF0A6A9B),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1.0,
      duration: const Duration(milliseconds: 150),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: isEnabled ? color : Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(32),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: color?.withValues(alpha: 0.4) ?? Colors.transparent,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: (isEnabled) ? onPressed : null,
            borderRadius: BorderRadius.circular(32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isEnabled ? text : loadingText ?? "LOADING...",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 8),
                isEnabled
                    ? Icon(icon, color: textColor, size: 24)
                    : SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: textColor,
                          strokeWidth: 3,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
