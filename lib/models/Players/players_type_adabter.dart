import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/Players/room_player_cache.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RoomPlayerCacheAdapter extends TypeAdapter<RoomPlayerCache> {
  @override
  final int typeId = 2;

  @override
  RoomPlayerCache read(BinaryReader reader) {
    return RoomPlayerCache(
      id: reader.readString(),
      firebaseID: reader.readString(),
      username: reader.readString(),
      lvl: reader.readInt(),
      avatarID: reader.readString(),
      playerRole: reader.readString(),
      roomPlayerStatus: reader.readString(),
      secretCode: reader.readString(),
      lastSeen: reader.readInt(),
      createdAt: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, RoomPlayerCache obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.firebaseID);
    writer.writeString(obj.username);
    writer.writeInt(obj.lvl);
    writer.writeString(obj.avatarID);
    writer.writeString(obj.playerRole);
    writer.writeString(obj.roomPlayerStatus);
    writer.writeString(obj.secretCode ?? "");
    writer.writeInt(obj.lastSeen);
    writer.writeInt(obj.createdAt);
  }
}

class PlayersTypeAdabter extends TypeAdapter<PlayerModel> {
  @override
  int get typeId => 7;

  @override
  PlayerModel read(BinaryReader reader) {
    return PlayerModel(
      id: reader.readString(),
      firebaseID: reader.readString(),
      username: reader.readString(),
      lvl: reader.readInt(),
      avatarID: reader.readString(),
      createdAt: Timestamp.fromMillisecondsSinceEpoch(reader.readInt()),
      lastSeen: Timestamp.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, PlayerModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.firebaseID);
    writer.writeString(obj.username);
    writer.writeInt(obj.lvl);
    writer.writeString(obj.avatarID);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeInt(obj.lastSeen.millisecondsSinceEpoch);
  }
}
