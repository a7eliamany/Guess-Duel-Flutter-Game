import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';

class LobbyModel {
  final List<RoomPlayer> roomPlayers;
  final RoomModel roomModel;
  final RoomPlayer currentPlayer;

  LobbyModel({
    required this.roomPlayers,
    required this.roomModel,
    required this.currentPlayer,
  });

  LobbyModel copyWith({
    List<RoomPlayer>? players,
    RoomModel? roomModel,
    RoomPlayer? currentPlayer,
  }) {
    return LobbyModel(
      roomPlayers: players ?? roomPlayers,
      roomModel: roomModel ?? this.roomModel,
      currentPlayer: currentPlayer ?? this.currentPlayer,
    );
  }
}
