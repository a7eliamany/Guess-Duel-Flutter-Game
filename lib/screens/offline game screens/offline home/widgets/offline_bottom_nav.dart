import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum OfflineNavTab { home, history }

class OfflineBottomNav extends StatelessWidget {
  final OfflineNavTab currentTab;
  final ValueChanged<OfflineNavTab>? onTabSelected;

  const OfflineBottomNav({
    super.key,
    this.currentTab = OfflineNavTab.home,
    this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1B1F2B).withValues(alpha: 0.6),
        border: Border(
          top: BorderSide(
            color: Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildNavItem(
                tab: OfflineNavTab.home,
                icon: Icons.home_rounded,
                label: 'HOME',
              ),
              const SizedBox(width: 32),
              _buildNavItem(
                tab: OfflineNavTab.history,
                icon: Icons.history_rounded,
                label: 'HISTORY',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required OfflineNavTab tab,
    required IconData icon,
    required String label,
  }) {
    final isSelected = tab == currentTab;
    final color = isSelected
        ? const Color(0xFF00F0FF)
        : const Color(0xFFB9CACB);

    return InkWell(
      onTap: () => onTabSelected?.call(tab),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28, color: color),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
