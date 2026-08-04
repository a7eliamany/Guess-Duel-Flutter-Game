import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class OfflineHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onProfileTap;

  const OfflineHeader({super.key, this.onProfileTap});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      height: preferredSize.height + topPadding,
      padding: EdgeInsets.only(top: topPadding, left: 16, right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F131E).withValues(alpha: 0.4),
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'HOME',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFFDFE2F2),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF313441),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('📡', style: TextStyle(fontSize: 10))
                        .animate(
                          autoPlay: true,
                          onPlay: (controller) => controller.repeat(),
                        )
                        .fadeOut(
                          duration: const Duration(
                            seconds: 1,
                            milliseconds: 500,
                          ),
                        )
                        .fadeIn(duration: const Duration(seconds: 1)),

                    const SizedBox(width: 4),
                    Text(
                      'OFFLINE',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFFB9CACB),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
