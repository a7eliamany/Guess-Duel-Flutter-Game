import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/models/History/history_model.dart';

/// 2x2 Grid displaying user statistics:
/// Games Played, Wins, Losses, and Win Rate (highlighted).
class StatsGridWidget extends StatelessWidget {
  final StatsModel statsModel;

  const StatsGridWidget({super.key, required this.statsModel});

  @override
  Widget build(BuildContext context) {
    const primaryCyan = Color(0xFF00F0FF);
    const primaryFixed = Color(0xFF7DF4FF);
    const tertiaryFixed = Color(0xFFFFD7F0);
    const errorColor = Color(0xFFFFB4AB);
    const onSurface = Color(0xFFDFE2F2);
    const onSurfaceVariant = Color(0xFFB9CACB);

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - 12) / 2;

        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // Games Played
            _StatCard(
              width: cardWidth,
              icon: Icons.sports_esports_outlined,
              iconColor: primaryFixed,
              value: statsModel.gamesPlayed.toString(),
              label: 'GAMES PLAYED',
              glowColor: primaryCyan,
              valueColor: onSurface,
              labelColor: onSurfaceVariant,
            ),

            // Wins
            _StatCard(
              width: cardWidth,
              icon: Icons.emoji_events_outlined,
              iconColor: tertiaryFixed,
              value: statsModel.wins.toString(),
              label: 'WINS',
              glowColor: tertiaryFixed,
              valueColor: onSurface,
              labelColor: onSurfaceVariant,
            ),

            // Losses
            _StatCard(
              width: cardWidth,
              icon: Icons.close_rounded,
              iconColor: errorColor,
              value: statsModel.losess.toString(),
              label: 'LOSSES',
              glowColor: errorColor,
              valueColor: onSurface,
              labelColor: onSurfaceVariant,
            ),

            // Win Rate (Highlighted hero card)
            _StatCard(
              width: cardWidth,
              icon: Icons.bar_chart_rounded,
              iconColor: primaryCyan,
              value: "${statsModel.winRate} %",
              label: 'WIN RATE',
              glowColor: primaryCyan,
              valueColor: primaryCyan,
              labelColor: primaryFixed,
              isHighlighted: true,
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final double width;
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final Color glowColor;
  final Color valueColor;
  final Color labelColor;
  final bool isHighlighted;

  const _StatCard({
    required this.width,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.glowColor,
    required this.valueColor,
    required this.labelColor,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    const surfaceContainer = Color(0xFF1B1F2B);
    const primaryCyan = Color(0xFF00F0FF);

    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isHighlighted ? null : surfaceContainer.withValues(alpha: 0.6),
          gradient: isHighlighted
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    surfaceContainer,
                    primaryCyan.withValues(alpha: 0.08),
                  ],
                )
              : null,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHighlighted
                ? primaryCyan.withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.05),
            width: 1,
          ),
          boxShadow: isHighlighted
              ? [
                  BoxShadow(
                    color: primaryCyan.withValues(alpha: 0.12),
                    blurRadius: 15,
                    spreadRadius: -3,
                  ),
                ]
              : null,
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Corner ambient radial glow
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: glowColor.withValues(alpha: 0.12),
                  boxShadow: [
                    BoxShadow(
                      color: glowColor.withValues(alpha: 0.2),
                      blurRadius: 20,
                      spreadRadius: 8,
                    ),
                  ],
                ),
              ),
            ),

            // Card Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: iconColor, size: 24),
                const SizedBox(height: 12),
                Text(
                  value,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: valueColor,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.8,
                    color: labelColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
