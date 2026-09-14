import 'package:flutter/material.dart';
import 'package:guess_duel/screens/get%20started/widgets/floating_accent.dart';

class AtmosphericBackground extends StatelessWidget {
  const AtmosphericBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // 1. Atmospheric Glowing Radial Gradients
        Positioned(
          top: -150,
          left: -150,
          child: IgnorePointer(
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF00E5FF).withValues(alpha: 0.12),
                    const Color(0xFF00E5FF).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -150,
          right: -150,
          child: IgnorePointer(
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFD4BBFF).withValues(alpha: 0.12),
                    const Color(0xFFD4BBFF).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.5 - 200,
          left: size.width * 0.1 - 200,
          child: IgnorePointer(
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFFFEAC0).withValues(alpha: 0.06),
                    const Color(0xFFFFEAC0).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ),
        // 2. Floating Symbols (Atmospheric Overlay)
        // Question Mark
        Positioned(
          top: size.height * 0.1,
          left: size.width * 0.15,
          child: FloatingAccent(
            duration: const Duration(seconds: 6),
            offset: 15.0,
            initialPhase: 0.0,
            child: Opacity(
              opacity: 0.15,
              child: Icon(
                Icons.question_mark,
                size: 60,
                color: const Color(0xFF00E5FF).withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
        // Casino
        Positioned(
          bottom: size.height * 0.2,
          right: size.width * 0.1,
          child: FloatingAccent(
            duration: const Duration(seconds: 6),
            offset: 15.0,
            initialPhase: 0.33,
            child: Opacity(
              opacity: 0.15,
              child: Icon(
                Icons.casino,
                size: 72,
                color: const Color(0xFFD4BBFF).withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
        // Pentagon
        Positioned(
          bottom: size.height * 0.35,
          left: size.width * 0.08,
          child: FloatingAccent(
            duration: const Duration(seconds: 6),
            offset: 15.0,
            initialPhase: 0.66,
            child: Opacity(
              opacity: 0.15,
              child: Icon(
                Icons.pentagon,
                size: 48,
                color: const Color(0xFFFEC931).withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
        // Category
        Positioned(
          top: size.height * 0.2,
          right: size.width * 0.2,
          child: FloatingAccent(
            duration: const Duration(seconds: 6),
            offset: 15.0,
            initialPhase: 0.16,
            child: Opacity(
              opacity: 0.15,
              child: Icon(
                Icons.category,
                size: 38,
                color: const Color(0xFFC3F5FF).withValues(alpha: 0.6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
