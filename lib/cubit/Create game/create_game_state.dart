abstract class CreateRoomState {}

class CreateRoomInitial extends CreateRoomState {}

class CreateRoomLoading extends CreateRoomState {}

class CreateRoomSuccess extends CreateRoomState {
  final String roomId;
  CreateRoomSuccess(this.roomId);
}

class CreateRoomError extends CreateRoomState {
  final String error;
  CreateRoomError({required this.error});
}
