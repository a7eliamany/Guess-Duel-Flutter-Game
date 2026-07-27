import 'package:flutter/material.dart';
import 'stat_card.dart';

class StatsRow extends StatelessWidget {
  final int gamesPlayed;
  final int wins;
  final String winRate;

  const StatsRow({
    super.key,
    required this.gamesPlayed,
    required this.wins,
    required this.winRate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 140,
      child: ListView(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        children: [
          StatCard(
            icon: Icons.sports_esports_rounded,
            label: 'Games Played',
            value: gamesPlayed.toString(),
            accentColor: theme.colorScheme.secondary,
          ),
          const SizedBox(width: 12),
          StatCard(
            icon: Icons.military_tech_rounded,
            label: 'Wins',
            value: wins.toString(),
            accentColor: theme.colorScheme.primary,
          ),
          const SizedBox(width: 12),
          StatCard(
            icon: Icons.analytics_rounded,
            label: 'Win Rate',
            value: winRate,
            accentColor: const Color(0xFFDAB9FF),
          ),
        ],
      ),
    );
  }
}
