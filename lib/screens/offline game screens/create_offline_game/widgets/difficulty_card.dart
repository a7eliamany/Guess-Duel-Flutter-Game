import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/screens/offline%20game%20screens/create_offline_game/widgets/difficulty_badge_info.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:remixicon/remixicon.dart';

class DifficultyCard extends StatelessWidget {
  final OfflineGameModel offlineGameModel;
  final String title;
  final bool isSelected;
  final Color accentColor;

  final VoidCallback onTap;

  const DifficultyCard({
    super.key,
    required this.title,
    required this.accentColor,
    required this.onTap,
    required this.offlineGameModel,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0x1A8F00FF) : const Color(0x99201F1F),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFFDAB9FF) : const Color(0x0DFFFFFF),
          width: isSelected ? 1.5 : 1.0,
        ),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color(0xFF8F00FF).withValues(alpha: 0.2),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ]
            : [],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Left Accent Line
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4,
                  decoration: BoxDecoration(
                    color: accentColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
                ),
              ),
              // Card Contents
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: accentColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 12,
                            runSpacing: 4,
                            children: [
                              DifficultyBadgeInfo(
                                icon: Icons.pin_outlined,
                                label: '${offlineGameModel.digits}-digit',
                              ),
                              DifficultyBadgeInfo(
                                icon: Icons.track_changes,
                                label:
                                    '${offlineGameModel.maxAttempts} attempts',
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          DifficultyBadgeInfo(
                            icon:
                                offlineGameModel.duration == TimerType.unlimited
                                ? RemixIcons.infinity_fill
                                : Icons.timer_outlined,
                            label: offlineGameModel.duration.label,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      isSelected
                          ? Icons.check_circle_rounded
                          : Icons.chevron_right_rounded,
                      color: isSelected
                          ? accentColor
                          : accentColor.withValues(alpha: 0.4),
                      size: 26,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
