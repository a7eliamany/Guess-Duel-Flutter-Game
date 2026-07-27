import 'package:guess_duel/models/lobby_model.dart';

abstract class LobbyDataState {}

class LobbyInitial extends LobbyDataState {}

class LobbyLoading extends LobbyDataState {}

class LobbyLoaded extends LobbyDataState {
  final LobbyModel lobbyModel;
  LobbyLoaded({required this.lobbyModel});
}

class LobbyFailure extends LobbyDataState {
  final String errorM;

  LobbyFailure({required this.errorM});
}

// class PlayerTwoPassiveS extends LobbyState {}

// class PlayerTwoActiveS extends LobbyState {}

// class PlayerTwoActiveReadyS extends LobbyState {}
