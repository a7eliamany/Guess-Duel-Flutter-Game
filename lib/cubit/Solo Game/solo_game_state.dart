import 'package:guess_duel/models/offline_game_model.dart';

// class SoloGameState {}

// class SoloGameInitial extends SoloGameState {}

// class SoloGameLoading extends SoloGameState {}

// class SoloGameLoaded extends SoloGameState {
//   final OfflineGameModel offlineGameModel;
//   final int? timeElapsed;

//   SoloGameLoaded({required this.offlineGameModel, this.timeElapsed});
// }

// class SoloGameFaliure extends SoloGameState {
//   final String errorMsg;
//   SoloGameFaliure({required this.errorMsg});
// }

class SoloGameState {
  final OfflineGameModel offlineGameModel;
  final int timeElapsed;
  final int attemptLeft;
  final GameState gameState;
  final bool isWin;

  SoloGameState({
    required this.offlineGameModel,
    required this.timeElapsed,
    required this.attemptLeft,
    required this.gameState,
    required this.isWin,
  });

  SoloGameState copyWith({
    OfflineGameModel? offlineGameModel,
    int? timeElapsed,
    int? attemptLeft,
    GameState? gameState,
    bool? isWin,
  }) {
    return SoloGameState(
      offlineGameModel: offlineGameModel ?? this.offlineGameModel,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      attemptLeft: attemptLeft ?? this.attemptLeft,
      gameState: gameState ?? this.gameState,
      isWin: isWin ?? this.isWin,
    );
  }
}

enum GameState { idle, playing, pause, stop, gameover, faliure }

extension GameStateExtension on GameState {
  bool get isGameOver => this == GameState.gameover;
  bool get isPlaying => this == GameState.playing;
}
