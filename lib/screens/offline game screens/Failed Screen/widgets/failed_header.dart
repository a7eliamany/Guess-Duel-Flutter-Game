import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FailedHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;

  const FailedHeader({super.key, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            color: const Color(0xFF131313).withValues(alpha: 0.8),
            border: const Border(
              bottom: BorderSide(color: Color(0x264D4356), width: 1),
            ),
          ),
          child: SizedBox(
            height: kToolbarHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed:
                        onBackPressed ?? () => Navigator.maybePop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFFDAB9FF),
                      size: 20,
                    ),
                    hoverColor: const Color(0xFFDAB9FF).withValues(alpha: 0.1),
                    splashRadius: 24,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'PUZZLE SUMMARY',
                    style: GoogleFonts.spaceGrotesk(
                      color: const Color(0xFFE5E2E1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
