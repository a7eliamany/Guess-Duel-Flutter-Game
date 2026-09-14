import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Renders the atmospheric glowing ambient background for auth screens matching
/// the exact radial gradients and positions from the reference design.
class AuthAmbientBackground extends StatelessWidget {
  final Widget? child;

  const AuthAmbientBackground({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Base dark cosmic background
        Container(color: const Color(0xFF0C101A)),

        // Top Ambient Glow (Purple & Cyan Radial Gradient)
        Positioned(
          top: -100,
          left: 0,
          right: 0,
          child: Center(
            child: IgnorePointer(
              child:
                  Container(
                        width: 480,
                        height: 380,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            center: Alignment.center,
                            radius: 0.5,
                            colors: [
                              Color.fromRGBO(112, 0, 255, 0.18),
                              Color.fromRGBO(0, 240, 255, 0.12),
                              Color.fromRGBO(10, 14, 25, 0),
                            ],
                            stops: [0.0, 0.4, 0.7],
                          ),
                        ),
                      )
                      .animate(
                        onPlay: (controller) =>
                            controller.repeat(reverse: true),
                      )
                      .scale(
                        begin: const Offset(1.0, 1.0),
                        end: const Offset(1.06, 1.06),
                        duration: 4000.ms,
                        curve: Curves.easeInOut,
                      ),
            ),
          ),
        ),

        // Bottom Ambient Glow (Magenta Radial Gradient)
        Positioned(
          bottom: 20,
          right: -80,
          child: IgnorePointer(
            child:
                Container(
                      width: 320,
                      height: 320,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          center: Alignment.center,
                          radius: 0.5,
                          colors: [
                            Color.fromRGBO(255, 42, 133, 0.12),
                            Color.fromRGBO(10, 14, 25, 0),
                          ],
                          stops: [0.0, 0.7],
                        ),
                      ),
                    )
                    .animate(
                      onPlay: (controller) => controller.repeat(reverse: true),
                    )
                    .scale(
                      begin: const Offset(1.0, 1.0),
                      end: const Offset(1.1, 1.1),
                      duration: 5000.ms,
                      curve: Curves.easeInOut,
                    ),
          ),
        ),

        ?child,
      ],
    );
  }
}
