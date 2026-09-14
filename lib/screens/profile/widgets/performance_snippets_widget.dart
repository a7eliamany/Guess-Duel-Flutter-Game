import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Data class for a performance streak or metric snippet.
class PerformanceSnippetItem {
  final String value;
  final String label;
  final String subtitle;
  final Color? valueColor;

  const PerformanceSnippetItem({
    required this.value,
    required this.label,
    required this.subtitle,
    this.valueColor,
  });
}

/// Horizontal scrollable snippet cards for win streaks and performance records.
class PerformanceSnippetsWidget extends StatelessWidget {
  final List<PerformanceSnippetItem>? items;
  final int currentStreak;
  final int bestStreak;

  const PerformanceSnippetsWidget({
    super.key,
    this.items,
    this.currentStreak = 0,
    this.bestStreak = 0,
  });

  @override
  Widget build(BuildContext context) {
    const primaryFixed = Color(0xFF7DF4FF);
    const onSurface = Color(0xFFDFE2F2);

    final snippetList =
        items ??
        [
          PerformanceSnippetItem(
            value: currentStreak.toString(),
            label: 'Win Streak',
            subtitle: 'Current 🔥',
            valueColor: primaryFixed,
          ),
          PerformanceSnippetItem(
            value: bestStreak.toString(),
            label: 'Win Streak',
            subtitle: 'All-time Best',
            valueColor: onSurface,
          ),
        ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: snippetList.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return Padding(
            padding: EdgeInsets.only(
              right: index < snippetList.length - 1 ? 12.0 : 0.0,
            ),
            child: _PerformanceSnippetCard(item: item),
          );
        }).toList(),
      ),
    );
  }
}

class _PerformanceSnippetCard extends StatelessWidget {
  final PerformanceSnippetItem item;

  const _PerformanceSnippetCard({required this.item});

  @override
  Widget build(BuildContext context) {
    const surfaceContainer = Color(0xFF1B1F2B);
    const surfaceContainerHighest = Color(0xFF313441);
    const onSurface = Color(0xFFDFE2F2);
    const onSurfaceVariant = Color(0xFFB9CACB);

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: 164,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: surfaceContainer.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.05),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Value Container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  item.value,
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: item.valueColor ?? onSurface,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              // Labels
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.label,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
