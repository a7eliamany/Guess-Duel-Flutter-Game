abstract class GameStatusState {}

class GameStateInitial extends GameStatusState {}

class GameStateLoading extends GameStatusState {}

class LobbyState extends GameStatusState {
  final String roomID;

  LobbyState({required this.roomID});
}

class SecretNumberState extends GameStatusState {
  final String roomID;

  SecretNumberState({required this.roomID});
}

class PlayingState extends GameStatusState {
  final String roomID;

  PlayingState({required this.roomID});
}

class GameStartFailure extends GameStatusState {
  final String errorM;
  GameStartFailure({required this.errorM});
}

class GameStateFailure extends GameStatusState {
  final String errorM;
  GameStateFailure({required this.errorM});
}

class GameStateDissmissed extends GameStatusState {}

class GameStateFinished extends GameStatusState {
  GameStateFinished();
}
