import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SoloChallengeTheme {
  SoloChallengeTheme._();

  // Dark Theme Base Colors
  static const Color surface = Color(0xFF131313);
  static const Color surfaceContainerLowest = Color(0xFF0E0E0E);
  static const Color surfaceContainerLow = Color(0xFF1C1B1B);
  static const Color surfaceContainer = Color(0xFF201F1F);
  static const Color surfaceContainerHigh = Color(0xFF2A2A2A);
  static const Color surfaceContainerHighest = Color(0xFF353534);

  // Accent Colors
  static const Color primary = Color(0xFFDAB9FF);
  static const Color primaryContainer = Color(0xFF8F00FF);
  static const Color onPrimary = Color(0xFF470083);
  static const Color onPrimaryContainer = Color(0xFFEFDDFF);

  static const Color secondary = Color(0xFFD3FBFF);
  static const Color secondaryContainer = Color(0xFF00EEFC);
  static const Color onSecondaryContainer = Color(0xFF00686F);

  static const Color outline = Color(0xFF988CA2);
  static const Color outlineVariant = Color(0xFF4D4356);
  static const Color surfaceTint = Color(0xFFDAB9FF);

  static const Color onSurface = Color(0xFFE5E2E1);
  static const Color onSurfaceVariant = Color(0xFFCFC2D9);
  static const Color error = Color(0xFFFFB4AB);

  // Glass Header Background
  static const Color glassHeaderBg = Color(0xCC131313); // 80% opacity #131313
  static const Color glassHeaderBorder = Color(0x264D4356);

  // Primary Button Gradient
  static const LinearGradient submitButtonGradient = LinearGradient(
    colors: [primaryContainer, Color(0xFFB800FF)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  // Text Styles (Space Grotesk & Manrope)
  static TextStyle headlineStyle({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.bold,
    Color color = onSurface,
    double? letterSpacing,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle displayStyle({
    double fontSize = 36,
    FontWeight fontWeight = FontWeight.bold,
    Color color = primary,
    double? letterSpacing,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle labelStyle({
    double fontSize = 10,
    FontWeight fontWeight = FontWeight.normal,
    Color color = outline,
    double? letterSpacing,
  }) {
    return GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle bodyStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = onSurface,
  }) {
    return GoogleFonts.manrope(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
