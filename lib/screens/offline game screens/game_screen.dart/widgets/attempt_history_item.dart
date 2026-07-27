import 'package:flutter/material.dart';

import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen.dart/widgets/feedback_legend.dart';
import '../../../../theme/solo_challenge_theme.dart';

class AttemptHistoryItem extends StatelessWidget {
  final AttemptModel item;
  final int index;
  final Function()? onTap;

  const AttemptHistoryItem({
    super.key,
    required this.item,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final formattedNumber = '#${index.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        decoration: BoxDecoration(
          color: SoloChallengeTheme.surfaceContainerLow.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Index & Guess String
            Row(
              children: [
                Text(
                  formattedNumber,
                  style: SoloChallengeTheme.labelStyle(
                    fontSize: 12,
                    color: SoloChallengeTheme.outline,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  item.attempt,
                  style: SoloChallengeTheme.displayStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4.0,
                    color: SoloChallengeTheme.onSurface,
                  ),
                ),
              ],
            ),
            // Right: Badges
            Row(
              children: [
                _buildBadge(
                  count: item.correctNumbers,
                  bgColor: Colors.green,
                  textColor: Colors.white,
                ),
                const SizedBox(width: 8),
                _buildBadge(
                  count: item.correctPlaces,
                  bgColor: SoloChallengeTheme.secondaryContainer.withValues(
                    alpha: 0.2,
                  ),
                  textColor: SoloChallengeTheme.secondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge({
    required int count,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(2),
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}

class AttemptHistoryList extends StatelessWidget {
  final List<AttemptModel> history;
  final Function(int)? onTap;

  const AttemptHistoryList({super.key, required this.history, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
          child: Text(
            'TRANSMISSION HISTORY',
            style: SoloChallengeTheme.labelStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              color: SoloChallengeTheme.outline,
            ),
          ),
        ),

        if (history.isEmpty)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            alignment: Alignment.center,
            child: Text(
              'No sequences submitted yet',
              style: SoloChallengeTheme.bodyStyle(
                fontSize: 12,
                color: SoloChallengeTheme.outline.withValues(alpha: 0.6),
              ),
            ),
          )
        else
          Column(
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: FeedbackLegend(),
              ),
              const SizedBox(height: 5),
              for (int i = 0; i < history.length; i++)
                AttemptHistoryItem(
                  item: history[i],
                  index: history.length - i,
                  onTap: () => onTap!(i),
                ),
            ],
          ),
      ],
    );
  }
}
