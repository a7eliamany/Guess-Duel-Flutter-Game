import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Functions/game_utils.dart';
import 'package:guess_duel/cubit/Solo%20Game/solo_game_cubit.dart';
import 'package:guess_duel/cubit/Solo%20Game/solo_game_state.dart';
import '../../../../theme/solo_challenge_theme.dart';

class ChallengeStatsCard extends StatelessWidget {
  final String modeName;
  final int totalTime;
  final int maxAttempts;
  final int digitCount;

  const ChallengeStatsCard({
    super.key,
    this.modeName = 'NORMAL',

    this.digitCount = 4,
    required this.totalTime,
    this.maxAttempts = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: [
          // Top Rail: Mode & Time Elapsed
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHALLENGE MODE',
                    style: SoloChallengeTheme.labelStyle(
                      fontSize: 10,
                      letterSpacing: 2.0,
                      color: SoloChallengeTheme.secondary.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        modeName.toUpperCase(),
                        style: SoloChallengeTheme.headlineStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: SoloChallengeTheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'TIME ELAPSED',
                    style: SoloChallengeTheme.labelStyle(
                      fontSize: 10,
                      letterSpacing: 2.0,
                      color: SoloChallengeTheme.outline,
                    ),
                  ),
                  const SizedBox(height: 2),

                  BlocSelector<SoloGameCubit, SoloGameState, int>(
                    selector: (state) => state.offlineGameModel.timeElapsed,
                    builder: (context, timeElapsed) {
                      final String elapsedFormattedTime = GameUtils.getTime(
                        timeElapsed,
                      );
                      final String maxTime = GameUtils.getTime(totalTime);
                      return Text(
                        (totalTime == 0)
                            ? elapsedFormattedTime
                            : "$maxTime / $elapsedFormattedTime",
                        style: SoloChallengeTheme.headlineStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: SoloChallengeTheme.onSurface,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Status Bento Box (2 Cards)
          Row(
            children: [
              // Sequence Card
              Expanded(
                child: _buildBentoCard(
                  label: 'SEQUENCE',
                  value: '$digitCount DIGITS',
                  valueColor: SoloChallengeTheme.onSurface,
                  icon: Icons.pin,
                ),
              ),
              const SizedBox(width: 12),

              // Energy Left Card
              BlocBuilder<SoloGameCubit, SoloGameState>(
                builder: (context, state) {
                  final attemptsLeft =
                      state.offlineGameModel.maxAttempts -
                      state.offlineGameModel.usedAttmeps;
                  return Expanded(
                    child: _buildBentoCard(
                      label: 'ATTEMPTS LEFT',
                      value: '$maxAttempts / $attemptsLeft',
                      valueColor: SoloChallengeTheme.secondaryContainer,
                      icon: Icons.refresh,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBentoCard({
    required String label,
    required String value,
    required Color valueColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: SoloChallengeTheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 0.12,
              child: Icon(icon, size: 36, color: SoloChallengeTheme.onSurface),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: SoloChallengeTheme.labelStyle(
                  fontSize: 10,
                  letterSpacing: 1.5,
                  color: SoloChallengeTheme.outline,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: SoloChallengeTheme.headlineStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
