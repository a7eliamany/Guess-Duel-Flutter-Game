import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

/// Top bar with optional live player counter status badge (with animated pulsing green dot)
/// and version indicator.
class AuthTopBar extends StatelessWidget {
  final String? statusText;
  final String versionText;

  const AuthTopBar({super.key, this.statusText, this.versionText = 'v2.4'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, bottom: 8),
      child: Row(
        mainAxisAlignment: statusText != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.end,
        children: [
          // Online Status Badge
          if (statusText != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A).withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFF1E293B), width: 1),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Pulsing emerald indicator
                  SizedBox(
                    width: 8,
                    height: 8,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF34D399),
                              ),
                            )
                            .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true),
                            )
                            .scale(
                              begin: const Offset(0.8, 0.8),
                              end: const Offset(1.3, 1.3),
                              duration: 1200.ms,
                              curve: Curves.easeInOut,
                            ),
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF34D399),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    statusText!,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF94A3B8),
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),

          // Version Tag
          Text(
            versionText,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF64748B),
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
