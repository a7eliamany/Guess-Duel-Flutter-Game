import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:guess_duel/models/Attempts/attempts_model.dart';

import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/screens/game%20summery/widgets/container_state.dart';
import 'package:guess_duel/screens/game%20summery/widgets/guess_card.dart';
import 'package:guess_duel/screens/game%20summery/widgets/mid_body.dart';
import 'package:remixicon/remixicon.dart';

class GameSummeryScreen extends StatelessWidget {
  final GameHistoryModel gameHistoryModel;

  const GameSummeryScreen({super.key, required this.gameHistoryModel});

  @override
  Widget build(BuildContext context) {
    final attemptsAcurracy = (gameHistoryModel.attemptsModel.isNotEmpty)
        ? accuracyCalculator(gameHistoryModel.attemptsModel)
        : 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Game Summary",
          style: GoogleFonts.spaceGrotesk(
            color: const Color(0xFFE5E2E1),
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(RemixIcons.share_2_fill),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),

                ContainerState(
                  isWin: gameHistoryModel.isWin,
                  names: gameHistoryModel.players,
                  dateTime: gameHistoryModel.dateTime,
                ),

                const SizedBox(height: 25),

                StatsContainer(
                  accuracy: attemptsAcurracy,
                  attempts: gameHistoryModel.attemptsModel.length,
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    const Icon(RemixIcons.history_line, size: 25),
                    const SizedBox(width: 12),
                    Text(
                      "GUESS HISTORY",
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: gameHistoryModel.attemptsModel.length,
                  itemBuilder: (context, index) {
                    final reversedAttempts = gameHistoryModel
                        .attemptsModel
                        .reversed
                        .toList();
                    final bool isGuessCorrect =
                        reversedAttempts[index].correctPlaces == 4;
                    return GuessCard(
                      index: index + 1,
                      attemptModel: reversedAttempts[index],
                      isGuessCorrect: isGuessCorrect,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

int accuracyCalculator(List<AttemptModel> attemptsModle) {
  double accuracy = 0;
  const double existNumberValue = 0.8;
  const double correctNumberValue = 1;

  for (var attempt in attemptsModle) {
    if (attempt.correctPlaces != 4) {
      accuracy = accuracy + (existNumberValue * attempt.correctNumbers);
      accuracy = accuracy + (correctNumberValue * attempt.correctPlaces);
    } else {
      accuracy = accuracy + (correctNumberValue * 8);
    }
  }

  return (accuracy / (8 * attemptsModle.length) * 100).round();
}
