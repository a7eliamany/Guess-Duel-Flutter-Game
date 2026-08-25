abstract class JoinRoomState {}

class JoinRoomInitial extends JoinRoomState {}

class JoinRoomLoading extends JoinRoomState {}

class JoinRoomLoaded extends JoinRoomState {
  final String roomId;
  JoinRoomLoaded({required this.roomId});
}

class CheckingRoomPassword extends JoinRoomState {
  final String password;

  CheckingRoomPassword({required this.password});
}

class CheckRoomFailure extends JoinRoomState {
  final String errorM;

  CheckRoomFailure({required this.errorM});
}

class JoinRoomFailure extends JoinRoomState {
  final String errorM;

  JoinRoomFailure({required this.errorM});
}
