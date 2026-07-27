import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_duel/extensions/game_status_extension.dart';
import 'package:guess_duel/models/Rooms/rooms_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RoomsTypeAdabter extends TypeAdapter<RoomModel> {
  @override
  int get typeId => 0;

  @override
  RoomModel read(BinaryReader reader) {
    return RoomModel(
      roomName: reader.readString(),
      roomId: reader.readString(),
      hostId: reader.readString(),
      maxPlayers: reader.readInt(),
      status: GameStatusExtension.fromFirestore(reader.readString()),
      createdAt: Timestamp.fromMillisecondsSinceEpoch(reader.readInt()),
      playersCount: reader.readInt(),
      currentTurnPlayerId: reader.readString(),
      winnerId: reader.readString(),
      secretnumbers: reader.readMap(),
      isPrivate: reader.readBool(),
    );
  }

  @override
  void write(BinaryWriter writer, RoomModel obj) {
    writer.writeString(obj.roomName);
    writer.writeString(obj.roomId);
    writer.writeString(obj.hostId);
    writer.writeInt(obj.maxPlayers);

    // GameStatus -> String
    writer.writeString(obj.status.toFirestore());

    // Timestamp -> int
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);

    writer.writeInt(obj.playersCount);
    writer.writeString(obj.currentTurnPlayerId);
    writer.writeString(obj.winnerId);
    writer.writeMap(obj.secretnumbers);
    writer.writeBool(obj.isPrivate);
  }
}
