import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:guess_duel/cubit/History/history_cubit.dart';

import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/failed_action_suite.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/failed_header.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/failed_performance_stats.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/failed_status_header.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/hud_particles_background.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/success_status_header.dart';

import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/target_reveal_card.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';

class SoloResultScreen extends HookWidget {
  final OfflineGameModel? resultData;
  final bool isWin;
  final VoidCallback? onRetryPressed;

  final VoidCallback? onModifyDifficulty;
  final VoidCallback? onBackPressed;

  const SoloResultScreen({
    super.key,
    this.resultData,
    this.onModifyDifficulty,
    this.onBackPressed,
    required this.isWin,
    required this.onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      if (resultData != null) {
        context.read<HistoryCubit>().addToHistory(
          roomID: resultData!.id,
          attempts: resultData?.history ?? [],
          isWin: isWin,
          players: ["me", "Solo"],
          secretCode: resultData?.secretCode ?? '1234',
          offlineGameModel: resultData,
        );

        HiveService.offlineGameBox.put(resultData!.id, resultData!);
      }
      return null;
    });
    final String secretCode = resultData?.secretCode ?? '1234';
    final int attemptsUsed = resultData?.usedAttmeps ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: FailedHeader(onBackPressed: onBackPressed),
      body: Stack(
        children: [
          // Background ambient HUD particles
          Positioned.fill(child: HudParticlesBackground(isWin: isWin)),

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
                          isWin
                              ? const SuccessStatusHeader()
                              : const FailedStatusHeader(),
                          const SizedBox(height: 16),
                          TargetRevealCard(secretCode: secretCode),
                          const SizedBox(height: 24),
                          FailedPerformanceStats(
                            attemptsUsed: attemptsUsed,
                            maxAttempts: resultData?.maxAttempts ?? 10,
                            timeTakenInSeconds: resultData?.timeElapsed ?? 300,
                            totalTimeInSeconds:
                                resultData?.duration.timeInSecs ?? 600,
                          ),
                          const SizedBox(height: 24),
                          ResultActionSuite(
                            onRetryPressed: onRetryPressed,
                            onModifyDifficultyPressed: onModifyDifficulty,
                          ),
                        ],
                      ),
                    ),
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
