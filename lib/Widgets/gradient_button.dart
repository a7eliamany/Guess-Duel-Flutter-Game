import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final List<Color> gradientColors;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    required this.gradientColors,
    required this.icon,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onPressed,
      borderRadius: BorderRadius.circular(4),
      child: AnimatedContainer(
        height: 56,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: isLoading
              ? const LinearGradient(colors: [Colors.grey, Colors.grey])
              : LinearGradient(colors: gradientColors),
          borderRadius: BorderRadius.circular(9),
        ),
        duration: const Duration(milliseconds: 300),
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
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 255, 255),
                        strokeWidth: 3,
                      )
                    : Icon(
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
