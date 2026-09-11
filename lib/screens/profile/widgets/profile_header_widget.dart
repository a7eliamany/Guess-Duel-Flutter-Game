import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Profile Header Widget displaying user avatar with gradient glow border,
/// online status indicator, name, handle, join date, and rank badge.
class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String username;
  final String joinDate;
  final String rank;
  final bool isOnline;
  final String? avatarUrl;

  const ProfileHeaderWidget({
    super.key,
    this.name = 'Ahmed',
    this.username = '@ahmed123',
    this.joinDate = 'Player since Aug 2026',
    this.rank = 'Duel Master',
    this.isOnline = true,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    const primaryCyan = Color(0xFF00F0FF);
    const primaryFixed = Color(0xFF7DF4FF);
    const onSurface = Color(0xFFDFE2F2);
    const onSurfaceVariant = Color(0xFFB9CACB);
    const surfaceContainer = Color(0xFF1B1F2B);
    const surfaceContainerHighest = Color(0xFF313441);
    const surfaceBg = Color(0xFF0F131E);
    const outlineVariant = Color(0xFF3B494B);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Avatar with gradient border and online indicator
        SizedBox(
          width: 112,
          height: 112,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Gradient outer ring
              Container(
                width: 112,
                height: 112,
                padding: const EdgeInsets.all(2.5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryCyan,
                      primaryCyan.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: surfaceContainerHighest,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: avatarUrl != null
                      ? Image.network(
                          avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                            child: Icon(
                              Icons.person_rounded,
                              size: 48,
                              color: primaryCyan,
                            ),
                          ),
                        )
                      : const Center(
                          child: Icon(
                            Icons.person_rounded,
                            size: 48,
                            color: primaryCyan,
                          ),
                        ),
                ),
              ),

              // Online status indicator dot
              if (isOnline)
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: surfaceBg,
                    ),
                    child: Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: primaryCyan,
                          boxShadow: [
                            BoxShadow(
                              color: primaryCyan.withValues(alpha: 0.85),
                              blurRadius: 8,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // User Display Name
        Text(
          name,
          style: GoogleFonts.spaceGrotesk(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: onSurface,
            letterSpacing: -0.5,
          ),
        ),

        const SizedBox(height: 4),

        // Handle & Join Date
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              username,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: onSurfaceVariant,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: outlineVariant,
              ),
            ),
            Text(
              joinDate,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: onSurfaceVariant,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Rank Badge
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: surfaceContainer.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: primaryCyan.withValues(alpha: 0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: primaryCyan.withValues(alpha: 0.15),
                    blurRadius: 15,
                    spreadRadius: -3,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.shield_outlined,
                    size: 18,
                    color: primaryFixed,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    rank.toUpperCase(),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      color: primaryFixed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
