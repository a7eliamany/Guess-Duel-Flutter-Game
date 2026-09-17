import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:guess_duel/cubit/History/history_cubit.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'widgets/result_header.dart';
import 'widgets/opponent_code_card.dart';
import 'widgets/total_guesses_card.dart';
import 'widgets/play_again_button.dart';

class GameResultScreen extends HookWidget {
  final String opponentSecretCode;
  final List<AttemptModel> attempts;
  final String roomID;
  final bool isWin;

  const GameResultScreen({
    super.key,
    required this.roomID,
    required this.opponentSecretCode,
    required this.attempts,
    required this.isWin,
  });

  static const Color background = Color(0xFF0E0E0E);
  static const Color surfaceContainerHighest = Color(0xFF262626);
  static const Color surfaceContainerLow = Color(0xFF131313);
  static const Color tertiary = Color(0xFFA9FFAC);
  static const Color secondary = Color(0xFFD674FF);
  static const Color secondaryContainer = Color(0xFF9900CF);
  static const Color onSurface = Colors.white;
  static const Color outlineVariant = Color(0xFF767575);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<HistoryCubit>().addToHistory(
        roomID: roomID,
        attempts: attempts,
        isWin: isWin,
        secretCode: opponentSecretCode,
        isOffline: false,
        playersmodels: [
          RoomPlayerCache.toPlayerModel(
            HiveService.playersBox.get(HiveBoxPlayers.currentPlayer(roomID))!,
          ),
          RoomPlayerCache.toPlayerModel(
            HiveService.playersBox.get(HiveBoxPlayers.opponentPlayer(roomID))!,
          ),
        ],
      );
      return null;
    }, []);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 60),
            Column(
              children: [
                ResultHeader(isWin: isWin),
                const SizedBox(height: 16),
                OpponentCodeCard(opponentSecretCode: opponentSecretCode),
              ],
            ),
            const SizedBox(height: 32),
            TotalGuessesCard(totalGuesses: attempts.length),
            const SizedBox(height: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PlayAgainButton(roomID: roomID),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
