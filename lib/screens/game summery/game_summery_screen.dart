import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/screens/game%20summery/widgets/container_state.dart';
import 'package:guess_duel/screens/game%20summery/widgets/guess_card.dart';
import 'package:guess_duel/screens/game%20summery/widgets/performance_insight.dart';
import 'package:guess_duel/screens/game%20summery/widgets/players_indicator.dart';
import 'package:guess_duel/screens/game%20summery/widgets/share_result_button.dart';
import 'package:guess_duel/screens/offline%20game%20screens/game_screen.dart/widgets/feedback_legend.dart';
import 'package:screenshot/screenshot.dart';

class GameSummeryScreen extends HookWidget {
  final GameHistoryModel gameHistoryModel;

  const GameSummeryScreen({super.key, required this.gameHistoryModel});

  @override
  Widget build(BuildContext context) {
    final screenshotController = useMemoized(() => ScreenshotController());
    final attemptsAccuracy = (gameHistoryModel.attemptsModel.isNotEmpty)
        ? accuracyCalculator(gameHistoryModel.attemptsModel)
        : 0;

    return Scaffold(
      backgroundColor: const Color(0xFF131313),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: Text(
          'Game Summary',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE5E2E1),
            letterSpacing: -0.3,
          ),
        ),
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: ListView(
              children: [
                // ── ScreenShot Section ──
                Screenshot(
                  controller: screenshotController,
                  child: Column(
                    children: [
                      // ── Result Hero Section ──
                      ResultHeroSection(
                        isWin: gameHistoryModel.isWin,
                        dateTime: gameHistoryModel.dateTime,
                        attemptCount: gameHistoryModel.attemptsModel.length,
                        accuracy: attemptsAccuracy,
                        secretCode: gameHistoryModel.secretCode,
                      ),

                      // ── Main Timeline Content ──
                      Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFF0E0E0E),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24),
                          ),
                          border: Border(
                            top: BorderSide(color: Color(0x334D4356)),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),

                              // ── Player Indicators ──
                              PlayersIndicator(
                                players: gameHistoryModel.players,
                              ),

                              const SizedBox(height: 24),

                              // ── Guess History Header ──
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    child: Text(
                                      'Guess History',
                                      style: GoogleFonts.spaceGrotesk(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFE5E2E1),
                                      ),
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: FeedbackLegend(),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // ── Timeline Attempt Cards ──
                              ...List.generate(
                                gameHistoryModel.attemptsModel.length,
                                (i) {
                                  final attempt =
                                      gameHistoryModel.attemptsModel[i];

                                  final isCorrect = attempt.correctPlaces == 4;
                                  return GuessCard(
                                    index: i + 1,
                                    attemptModel: attempt,
                                    isGuessCorrect: isCorrect,
                                    digitsCount:
                                        gameHistoryModel.secretCode.length,
                                  );
                                },
                              ),

                              // ── Performance Insights ──
                              PerformanceInsights(
                                accuracy: attemptsAccuracy,
                                attempts: gameHistoryModel.attemptsModel.length,
                              ),

                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Footer ──
          ShareResultButton(screenshotController: screenshotController),
        ],
      ),
    );
  }
}

int accuracyCalculator(List<AttemptModel> attemptsModle) {
  double accuracy = 0;
  const double existNumberValue = 0.5;
  const double correctNumberValue = 1;

  for (var attempt in attemptsModle) {
    if (attempt.correctNumbers == 0) {
      accuracy = accuracy + 8;
    } else if (attempt.correctPlaces != 4) {
      accuracy = accuracy + (existNumberValue * attempt.correctNumbers);
      accuracy = accuracy + (correctNumberValue * attempt.correctPlaces);
    } else {
      accuracy = accuracy + (correctNumberValue * 8);
    }
  }

  return (accuracy / (8 * attemptsModle.length) * 100).round();
}
