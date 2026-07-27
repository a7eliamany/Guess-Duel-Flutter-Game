import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Functions/game_utils.dart';
import 'package:guess_duel/cubit/Solo%20Game/solo_game_state.dart';

import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/offline_game_model.dart';

class SoloGameCubit extends Cubit<SoloGameState> {
  final OfflineGameModel offlineGameModel;

  SoloGameCubit({required this.offlineGameModel})
    : super(
        SoloGameState(
          offlineGameModel: offlineGameModel,
          timeElapsed: 0,
          attemptLeft: offlineGameModel.attempts,
          gameState: GameState.playing,
          isWin: false,
        ),
      );

  Future<OfflineGameModel> addAttempt(
    String currentInput,
    OfflineGameModel offlineGameModel,
  ) async {
    if (offlineGameModel.attempts == 0) {
      return offlineGameModel;
    }

    if (currentInput.length == offlineGameModel.digits) {
      final Map<String, int> result = currentInput.checkAttempt(
        secretNumber: offlineGameModel.secretCode,
      );

      final AttemptModel attemptModel = AttemptModel(
        attempt: currentInput,
        userId: 'null',
        correctNumbers: result['correctNumbers']!,
        correctPlaces: result['correctPlaces']!,
        createdAt: Timestamp.now(),
      );

      offlineGameModel = offlineGameModel.copyWith(
        attempts: offlineGameModel.attempts - 1,
        history: [...offlineGameModel.history ?? [], attemptModel],
      );

      emit(
        state.copyWith(
          offlineGameModel: offlineGameModel,
          attemptLeft: offlineGameModel.attempts,
        ),
      );
      if (result['correctPlaces'] == offlineGameModel.digits) {
        _timer?.cancel();
        emit(state.copyWith(gameState: GameState.gameover, isWin: true));
      } else if (offlineGameModel.attempts == 0) {
        emit(state.copyWith(gameState: GameState.gameover, isWin: false));
        _timer?.cancel();
      }

      return offlineGameModel;
    } else {
      return offlineGameModel;
    }
  }

  Timer? _timer;

  void startTimer() {
    int timeElapsed = state.timeElapsed!;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(state.copyWith(timeElapsed: timeElapsed++));
      if (timeElapsed == offlineGameModel.timer.timeInSecs) {
        _timer?.cancel();
        emit(state.copyWith(gameState: GameState.gameover, isWin: false));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
