import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/failed_action_suite.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/failed_header.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/failed_performance_stats.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/failed_status_header.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/hud_particles_background.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/success_status_header.dart';
import 'package:guess_duel/screens/offline%20game%20screens/Result%20Screen/widgets/target_reveal_card.dart';
import 'package:guess_duel/screens/offline%20game%20screens/create_offline_game/offline_create_bs.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen/widgets/exit_dialog_solo.dart';

class SoloResultScreen extends StatelessWidget {
  final OfflineGameModel? resultData;
  final bool isWin;
  final VoidCallback? onRetryPressed;

  const SoloResultScreen({
    super.key,
    this.resultData,
    required this.isWin,
    required this.onRetryPressed,
  });

  @override
  Widget build(BuildContext context) {
    final String secretCode = resultData?.secretCode ?? '1234';
    final int attemptsUsed = resultData?.usedAttmeps ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: FailedHeader(
        onBackPressed: () {
          Get.back();
        },
      ),
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
                            onModifyDifficultyPressed: () async {
                              final bool canPop = await soloExitDialog(
                                context: context,
                              );
                              if (canPop == true) {
                                Get.until((route) => route.isFirst);
                                OfflineCreateBs.show(context);
                              }
                            },
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
