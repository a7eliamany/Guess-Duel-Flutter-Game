import 'package:flutter/material.dart';

class AppTheme {
  // Dark Theme Colors
  static const Color primary = Color(0xFF8FF5FF);
  static const Color primaryContainer = Color(0xFF00EEFC);
  static const Color secondary = Color(0xFFD674FF);
  static const Color tertiary = Color(0xFFA9FFAC);
  static const Color neutral = Color(0xFF0E0E0E);

  static const Color surface = Color(0xFF131313);
  static const Color surfaceAlt = Color(0xFF262626);
  static const Color outline = Color(0x26484847);
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textMuted = Color(0xFFB8B8B8);

  // Light Theme Colors
  static const Color primaryLight = Color(0xFF006B75);
  static const Color primaryContainerLight = Color(0xFF00EEFC);
  static const Color secondaryLight = Color(0xFF8B25C6);
  static const Color tertiaryLight = Color(0xFF00833E);
  static const Color neutralLight = Color(0xFFF5F7FA);

  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceAltLight = Color(0xFFECEFF3);
  static const Color outlineLight = Color(0xFFE2E8F0);
  static const Color textPrimaryLight = Color(0xFF1A1D1F);
  static const Color textMutedLight = Color(0xFF6F767E);

  static ThemeData get lightTheme {
    final base = ThemeData.light(useMaterial3: true);

    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: Colors.white,
      secondary: secondaryLight,
      onSecondary: Colors.white,
      tertiary: tertiaryLight,
      onTertiary: Colors.white,
      error: Color(0xFFD32F2F),
      onError: Colors.white,
      surface: surfaceLight,
      onSurface: textPrimaryLight,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: neutralLight,
      canvasColor: neutralLight,
      cardColor: surfaceLight,
      dividerColor: outlineLight,
      textTheme: base.textTheme.apply(
        bodyColor: textPrimaryLight,
        displayColor: textPrimaryLight,
      ).copyWith(
        headlineLarge: const TextStyle(
          fontSize: 46,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.6,
          height: 0.95,
        ),
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: textMutedLight,
          height: 1.45,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: textMutedLight,
          height: 1.4,
        ),
        labelLarge: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
        labelMedium: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: neutralLight,
        foregroundColor: textPrimaryLight,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceAltLight,
        hintStyle: const TextStyle(color: textMutedLight),
        prefixIconColor: textMutedLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: secondaryLight, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primaryLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimaryLight,
          backgroundColor: surfaceAltLight,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: surfaceAltLight,
        selectedColor: secondaryLight.withValues(alpha: 0.2),
        secondarySelectedColor: secondaryLight,
        labelStyle: const TextStyle(color: textPrimaryLight),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        side: BorderSide.none,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: tertiaryLight,
        foregroundColor: Colors.white,
      ),
      iconTheme: const IconThemeData(color: textPrimaryLight),
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData.dark(useMaterial3: true);

    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: Colors.black,
      secondary: secondary,
      onSecondary: Colors.white,
      tertiary: tertiary,
      onTertiary: Colors.black,
      error: Color(0xFFFF716C),
      onError: Colors.white,
      surface: surface,
      onSurface: textPrimary,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: neutral,
      canvasColor: neutral,
      cardColor: surface,
      dividerColor: outline,
      textTheme: base.textTheme.apply(
        bodyColor: textPrimary,
        displayColor: textPrimary,
      ).copyWith(
        headlineLarge: const TextStyle(
          fontSize: 46,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.6,
          height: 0.95,
        ),
        headlineMedium: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.8,
        ),
        titleLarge: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
        ),
        titleMedium: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.1,
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          color: textMuted,
          height: 1.45,
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          color: textMuted,
          height: 1.4,
        ),
        labelLarge: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
        labelMedium: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: neutral,
        foregroundColor: textPrimary,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceAlt,
        hintStyle: const TextStyle(color: textMuted),
        prefixIconColor: textMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: secondary, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: primary,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: textPrimary,
          backgroundColor: surfaceAlt,
          side: BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: surfaceAlt,
        selectedColor: secondary.withValues(alpha: 0.2),
        secondarySelectedColor: secondary,
        labelStyle: const TextStyle(color: textPrimary),
        secondaryLabelStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        side: BorderSide.none,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: tertiary,
        foregroundColor: Colors.black,
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    );
  }
}
