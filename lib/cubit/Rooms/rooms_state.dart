import 'package:guess_duel/models/Rooms/rooms_model.dart';

abstract class RoomsState {}

class RoomsInitial extends RoomsState {}

class RoomsLoading extends RoomsState {}

class RoomsLoaded extends RoomsState {
  final List<RoomModel> rooms;
  RoomsLoaded(this.rooms);
}

class RoomsError extends RoomsState {
  final String error;
  RoomsError(this.error);
}
