import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttemptsSlider extends StatelessWidget {
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onChanged;

  const AttemptsSlider({
    super.key,
    required this.value,
    this.min = 5,
    this.max = 30,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Max Attempts',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFCFC2D9),
              ),
            ),
            Text(
              '${value.round()}',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFDAB9FF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        SliderTheme(
          data: const SliderThemeData(
            activeTrackColor: Color(0xFF8F00FF),
            inactiveTrackColor: Color(0xFF353534),
            thumbColor: Color(0xFFDAB9FF),
            overlayColor: Color(0x338F00FF),
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${min.round()}',
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: const Color(0xFF988CA2),
                ),
              ),
              Text(
                '${((min + max) / 2).round()}',
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: const Color(0xFF988CA2),
                ),
              ),
              Text(
                '${max.round()}',
                style: GoogleFonts.manrope(
                  fontSize: 10,
                  color: const Color(0xFF988CA2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
