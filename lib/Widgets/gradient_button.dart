import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final List<Color> gradientColors;
  final IconData icon;
  final VoidCallback onPressed;

  const GradientButton({
    super.key,
    required this.text,
    required this.gradientColors,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradientColors),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.spaceGrotesk(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 16,
              child: Opacity(
                opacity: 0.7,
                child: Icon(
                  icon,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  size: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
