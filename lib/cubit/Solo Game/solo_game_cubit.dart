import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_duel/Functions/game_utils.dart';
import 'package:guess_duel/Functions/random_f.dart';
import 'package:guess_duel/cubit/Solo%20Game/solo_game_state.dart';

import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';

class SoloGameCubit extends Cubit<SoloGameState> {
  final OfflineGameModel offlineGameModel;

  SoloGameCubit({required this.offlineGameModel})
    : super(
        SoloGameState(
          offlineGameModel: offlineGameModel,

          gameState: GameState.playing,
          isWin: false,
        ),
      );

  Future<OfflineGameModel> addAttempt(
    String currentInput,
    OfflineGameModel offlineGameModel,
  ) async {
    if (offlineGameModel.usedAttmeps == offlineGameModel.maxAttempts) {
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
        usedAttmeps: offlineGameModel.usedAttmeps + 1,
        history: [...offlineGameModel.history ?? [], attemptModel],
      );

      emit(state.copyWith(offlineGameModel: offlineGameModel));
      if (result['correctPlaces'] == offlineGameModel.digits) {
        _timer?.cancel();
        emit(state.copyWith(gameState: GameState.gameover, isWin: true));
      } else if (offlineGameModel.usedAttmeps == offlineGameModel.maxAttempts) {
        emit(state.copyWith(gameState: GameState.gameover, isWin: false));
        _timer?.cancel();
      }

      return offlineGameModel;
    } else {
      return offlineGameModel;
    }
  }

  void soloRestartAction() {
    // generate new Code and id
    final newSecretNumber = RandomF.generateSecretCode(
      state.offlineGameModel.digits,
      state.offlineGameModel.allowRepeatedDigits,
    );

    final newGameId = RandomF.getRandomRoomID(6);

    // reset
    emit(
      state.copyWith(
        offlineGameModel: offlineGameModel.copyWith(
          secretCode: newSecretNumber,
          id: newGameId,
        ),

        gameState: GameState.playing,
        isWin: false,
      ),
    );
    _timer?.cancel();
    startTimer();
  }

  Timer? _timer;

  void startTimer() {
    int totalTimeInSecs = offlineGameModel.duration.timeInSecs;
    int timeElabsed = offlineGameModel.timeElapsed;

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (offlineGameModel.duration != TimerType.unlimited &&
          timeElabsed == totalTimeInSecs) {
        emit(state.copyWith(gameState: GameState.gameover, isWin: false));
        _timer?.cancel();
      }
      timeElabsed++;

      emit(
        state.copyWith(
          offlineGameModel: state.offlineGameModel.copyWith(
            timeElapsed: timeElabsed,
          ),
        ),
      );
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
