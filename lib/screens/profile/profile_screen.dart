import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';
import 'package:guess_duel/screens/profile/widgets/guest_account_banner_widget.dart';
import 'package:guess_duel/screens/profile/widgets/performance_snippets_widget.dart';
import 'package:guess_duel/screens/profile/widgets/profile_header_widget.dart';
import 'package:guess_duel/screens/profile/widgets/profile_settings_list_widget.dart';
import 'package:guess_duel/screens/profile/widgets/recent_form_chart_widget.dart';
import 'package:guess_duel/screens/profile/widgets/stats_grid_widget.dart';

/// Main Profile Screen for Guess Duel.
/// Assembles ambient background glows, top glass app bar, modular profile sections,
/// and fixed glass bottom navigation bar.
class ProfileScreen extends StatelessWidget {
  final bool showBottomNav;
  final ValueChanged<int>? onBottomNavTap;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onCreateAccount;
  final VoidCallback? onLogout;

  const ProfileScreen({
    super.key,
    this.showBottomNav = true,
    this.onBottomNavTap,
    this.onNotificationTap,
    this.onCreateAccount,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    const bgDark = Color(0xFF0F131E);
    const primaryCyan = Color(0xFF00F0FF);
    const onSurface = Color(0xFFDFE2F2);
    const onSurfaceVariant = Color(0xFFB9CACB);
    const glassBg = Color(0x661B1F2B);

    final topPadding = MediaQuery.paddingOf(context).top;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: bgDark,
      body: Stack(
        children: [
          // 1. Ambient Background Glows
          Positioned(
            top: -100,
            left: -80,
            child: IgnorePointer(
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryCyan.withValues(alpha: 0.08),
                  boxShadow: [
                    BoxShadow(
                      color: primaryCyan.withValues(alpha: 0.08),
                      blurRadius: 140,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.4,
            right: -100,
            child: IgnorePointer(
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFDBFCFF).withValues(alpha: 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFDBFCFF).withValues(alpha: 0.04),
                      blurRadius: 120,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 2. Scrollable Body Content
          SafeArea(
            top: false,
            bottom: false,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                top: topPadding + 64, // Space for fixed glass header
                bottom: showBottomNav ? (bottomPadding + 96) : 32,
                left: 16,
                right: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 12),

                  // Header / Avatar & Info
                  const ProfileHeaderWidget(),

                  const SizedBox(height: 24),

                  // Stats Grid (2x2)
                  const StatsGridWidget(),

                  const SizedBox(height: 16),

                  // Performance Snippets (Horizontal scrollable streak cards)
                  const PerformanceSnippetsWidget(),

                  const SizedBox(height: 24),

                  // Recent Performance Chart (Form)
                  const RecentFormChartWidget(),

                  const SizedBox(height: 28),

                  // Divider
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),

                  const SizedBox(height: 24),

                  // Settings List
                  ProfileSettingsListWidget(
                    onNotificationsTap: () {},
                    onSoundTap: () {},
                    onVibrationTap: () {},
                    onAppearanceTap: () {},
                  ),

                  const SizedBox(height: 24),

                  // Guest Account Banner & Buttons
                  GuestAccountBannerWidget(
                    onCreateAccount: onCreateAccount,
                    onLogout: onLogout,
                  ),
                ],
              ),
            ),
          ),

          // 3. Pinned Top Glass Header (AppBar)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: EdgeInsets.only(
                    top: topPadding,
                    left: 16,
                    right: 16,
                  ),
                  height: topPadding + 56,
                  decoration: BoxDecoration(
                    color: glassBg,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.05),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo & Title
                      Row(
                        children: [
                          const Icon(
                            RemixIcons.sword_line,
                            color: primaryCyan,
                            size: 22,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'PROFILE',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: onSurface,
                            ),
                          ),
                        ],
                      ),

                      // Actions
                      Row(
                        children: [
                          IconButton(
                            onPressed: onNotificationTap,
                            icon: const Icon(
                              Icons.notifications_none_rounded,
                              color: onSurfaceVariant,
                              size: 22,
                            ),
                            splashRadius: 20,
                          ),
                          const SizedBox(width: 4),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: primaryCyan.withValues(alpha: 0.25),
                                width: 2,
                              ),
                            ),
                            child: ClipOval(
                              child: Container(
                                color: const Color(0xFF313441),
                                child: const Icon(
                                  Icons.person_rounded,
                                  size: 20,
                                  color: primaryCyan,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 4. Fixed Glass Bottom Navigation Bar
          if (showBottomNav)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    padding: EdgeInsets.only(bottom: bottomPadding),
                    height: bottomPadding + 64,
                    decoration: BoxDecoration(
                      color: glassBg,
                      border: Border(
                        top: BorderSide(
                          color: Colors.white.withValues(alpha: 0.05),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _BottomNavItem(
                          icon: Icons.home_outlined,
                          label: 'Home',
                          isActive: false,
                          onTap: () => onBottomNavTap?.call(0),
                        ),
                        _BottomNavItem(
                          icon: Icons.history_rounded,
                          label: 'History',
                          isActive: false,
                          onTap: () => onBottomNavTap?.call(1),
                        ),
                        _BottomNavItem(
                          icon: Icons.person_rounded,
                          label: 'Profile',
                          isActive: true,
                          onTap: () => onBottomNavTap?.call(2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primaryCyan = Color(0xFF00F0FF);
    const onSurfaceVariant = Color(0xFFB9CACB);

    const activeColor = primaryCyan;
    const inactiveColor = onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 64,
        height: 52,
        decoration: BoxDecoration(
          color: isActive
              ? primaryCyan.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                color: isActive ? activeColor : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
