abstract class JoinRoomState {}

class JoinRoomInitial extends JoinRoomState {}

class JoinRoomLoading extends JoinRoomState {}

class JoinRoomLoaded extends JoinRoomState {
  final String roomId;
  JoinRoomLoaded({required this.roomId});
}

class JoinRoomFailure extends JoinRoomState {
  final String errorM;

  JoinRoomFailure({required this.errorM});
}
