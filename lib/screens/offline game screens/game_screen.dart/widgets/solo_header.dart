import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../theme/solo_challenge_theme.dart';

class SoloHeader extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final String title;

  const SoloHeader({
    super.key,
    this.onBackPressed,

    this.title = 'SOLO CHALLENGE',
  });

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: preferredSize.height + MediaQuery.of(context).padding.top,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            left: 16,
            right: 16,
          ),
          decoration: const BoxDecoration(
            color: SoloChallengeTheme.glassHeaderBg,
            border: Border(
              bottom: BorderSide(
                color: SoloChallengeTheme.glassHeaderBorder,
                width: 1,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left: Back button & Title
              Row(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onBackPressed,
                      borderRadius: BorderRadius.circular(4),
                      child: Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: SoloChallengeTheme.primary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: SoloChallengeTheme.headlineStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: SoloChallengeTheme.onSurface,
                    ),
                  ),
                ],
              ),

              // Right: Restart & User Avatar
            ],
          ),
        ),
      ),
    );
  }
}
