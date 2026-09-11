import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Settings options list card displaying Notifications, Sound, Vibration, and Appearance.
class ProfileSettingsListWidget extends StatelessWidget {
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onSoundTap;
  final VoidCallback? onVibrationTap;
  final VoidCallback? onAppearanceTap;

  const ProfileSettingsListWidget({
    super.key,
    this.onNotificationsTap,
    this.onSoundTap,
    this.onVibrationTap,
    this.onAppearanceTap,
  });

  @override
  Widget build(BuildContext context) {
    const surfaceContainer = Color(0xFF1B1F2B);
    const onSurface = Color(0xFFDFE2F2);
    const onSurfaceVariant = Color(0xFFB9CACB);

    final divider = Divider(
      height: 1,
      thickness: 1,
      color: Colors.white.withValues(alpha: 0.05),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              decoration: BoxDecoration(
                color: surfaceContainer.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _SettingItemTile(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    onTap: onNotificationsTap,
                    textColor: onSurface,
                    iconColor: onSurfaceVariant,
                  ),
                  divider,
                  _SettingItemTile(
                    icon: Icons.volume_up_outlined,
                    title: 'Sound',
                    onTap: onSoundTap,
                    textColor: onSurface,
                    iconColor: onSurfaceVariant,
                  ),
                  divider,
                  _SettingItemTile(
                    icon: Icons.vibration_rounded,
                    title: 'Vibration',
                    onTap: onVibrationTap,
                    textColor: onSurface,
                    iconColor: onSurfaceVariant,
                  ),
                  divider,
                  _SettingItemTile(
                    icon: Icons.palette_outlined,
                    title: 'Appearance',
                    onTap: onAppearanceTap,
                    textColor: onSurface,
                    iconColor: onSurfaceVariant,
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

class _SettingItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color textColor;
  final Color iconColor;

  const _SettingItemTile({
    required this.icon,
    required this.title,
    this.onTap,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white.withValues(alpha: 0.05),
        highlightColor: Colors.white.withValues(alpha: 0.02),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 22,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: iconColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
