import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Bar chart representing the user's recent form (last 10 games).
class RecentFormChartWidget extends StatelessWidget {
  final int winsCount;
  final int lossesCount;
  final List<double> barHeights;
  final List<bool> isWinList;

  const RecentFormChartWidget({
    super.key,
    this.winsCount = 7,
    this.lossesCount = 3,
    this.barHeights = const [
      0.85,
      0.95,
      0.40,
      0.75,
      0.90,
      0.35,
      0.80,
      1.00,
      0.50,
      0.85,
    ],
    this.isWinList = const [
      true,
      true,
      false,
      true,
      true,
      false,
      true,
      true,
      false,
      true,
    ],
  });

  @override
  Widget build(BuildContext context) {
    const primaryCyan = Color(0xFF00F0FF);
    const errorColor = Color(0xFFFFB4AB);
    const onSurface = Color(0xFFDFE2F2);
    const onSurfaceVariant = Color(0xFFB9CACB);
    const surfaceContainerLow = Color(0xFF171B27);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          'Form',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: onSurface,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Last 10 Games: $winsCount Wins · $lossesCount Losses',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),

        // Chart Panel
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              height: 128,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: surfaceContainerLow.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.05),
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(barHeights.length, (index) {
                  final heightFactor = barHeights[index].clamp(0.1, 1.0);
                  final isWin =
                      index < isWinList.length ? isWinList[index] : true;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween<double>(begin: 0.0, end: heightFactor),
                        duration: Duration(milliseconds: 400 + (index * 60)),
                        curve: Curves.easeOutCubic,
                        builder: (context, animatedFactor, child) {
                          return FractionallySizedBox(
                            heightFactor: animatedFactor,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isWin
                                    ? primaryCyan
                                    : errorColor.withValues(alpha: 0.4),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(999),
                                ),
                                boxShadow: isWin
                                    ? [
                                        BoxShadow(
                                          color: primaryCyan
                                              .withValues(alpha: 0.45),
                                          blurRadius: 8,
                                          offset: const Offset(0, -1),
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
