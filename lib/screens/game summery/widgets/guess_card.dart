import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';

class GuessCard extends StatelessWidget {
  final int index;
  final AttemptModel attemptModel;
  final bool isGuessCorrect;
  const GuessCard({
    super.key,
    required this.index,
    required this.attemptModel,
    required this.isGuessCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final correct = attemptModel.correctPlaces;
    final exist = attemptModel.correctNumbers - correct;
    final wrong = 4 - (correct + exist);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 50,

            decoration: BoxDecoration(
              color: isGuessCorrect
                  ? const Color(0xFFDAB9FF)
                  : const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF988CA2), width: 2),
            ),
            child: Center(
              child: Text(
                index.toString().padLeft(2, "0"),

                style: GoogleFonts.spaceGrotesk(
                  color: isGuessCorrect ? Colors.black : Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 5,
          child: SizedBox(
            height: 110,
            child: Card(
              color: isGuessCorrect
                  ? const Color(0xFFDAB9FF).withValues(alpha: 0.2)
                  : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  isGuessCorrect ? "WINNING GUESS" : "GUESS",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 12,
                    color: isGuessCorrect
                        ? Colors.white
                        : const Color(0xFF988CA2),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    attemptModel.attempt,
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                trailing: SizedBox(
                  height: 15,
                  width: 66,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < correct; i++)
                        const ResultSquare(state: GuessState.correct),

                      for (int i = 0; i < exist; i++)
                        const ResultSquare(state: GuessState.exist),

                      for (int i = 0; i < wrong; i++)
                        const ResultSquare(state: GuessState.wrong),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum GuessState { correct, exist, wrong }

class ResultSquare extends StatelessWidget {
  final GuessState state;
  const ResultSquare({super.key, required this.state});

  Color get color {
    switch (state) {
      case GuessState.correct:
        return Colors.greenAccent;
      case GuessState.exist:
        return Colors.amber;
      case GuessState.wrong:
        return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: color,
      ),
    );
  }
}
