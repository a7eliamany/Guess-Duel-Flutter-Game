import 'package:flutter/material.dart';
import 'package:guess_duel/models/offline_game_model.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Failed%20Screen/widgets/failed_action_suite.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Failed%20Screen/widgets/failed_header.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Failed%20Screen/widgets/failed_performance_stats.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Failed%20Screen/widgets/failed_status_header.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Failed%20Screen/widgets/hud_particles_background.dart';

import 'package:guess_duel/screens/offline%20game%20screens/Failed%20Screen/widgets/target_reveal_card.dart';

class FailedScreen extends StatelessWidget {
  final OfflineGameModel? offlineGameModel;

  final int? attempts;
  final int maxAttempts;
  final int? timeTakenInSeconds;

  final VoidCallback? onModifyDifficulty;
  final VoidCallback? onBackPressed;
  final VoidCallback? onRetryPressed;

  const FailedScreen({
    super.key,
    this.offlineGameModel,

    this.attempts,
    this.maxAttempts = 10,

    this.onModifyDifficulty,
    this.onBackPressed,
    this.onRetryPressed,
    this.timeTakenInSeconds,
  });

  @override
  Widget build(BuildContext context) {
    final String secretCode = offlineGameModel?.secretCode ?? '1234';
    final int attemptsUsed = maxAttempts - (offlineGameModel?.attempts ?? 10);

    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: FailedHeader(onBackPressed: onBackPressed),
      body: Stack(
        children: [
          // Background ambient HUD particles
          const Positioned.fill(child: HudParticlesBackground()),

          // Main scrollable content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 8),
                          const FailedStatusHeader(),
                          const SizedBox(height: 16),
                          TargetRevealCard(secretCode: secretCode),
                          const SizedBox(height: 24),
                          FailedPerformanceStats(
                            attemptsUsed: attemptsUsed,
                            maxAttempts: maxAttempts,
                            timeTakenInSeconds: timeTakenInSeconds ?? 300,
                            totalTimeInSeconds:
                                offlineGameModel?.timer.timeInSecs ?? 600,
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                  FailedActionSuite(
                    onRetryPressed: onRetryPressed,
                    onModifyDifficultyPressed: onModifyDifficulty,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
