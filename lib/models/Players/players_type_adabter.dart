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
//  instruction to migrate to another version

/// 1- change [currentVersion]
/// 2- edit [_readV1] to avoid null
/// 3- add new version
/// 4- edit the writer

class PlayersTypeAdabter extends TypeAdapter<PlayerModel> {
  @override
  int get typeId => 7;

  final int currentVersion = 1;

  @override
  PlayerModel read(BinaryReader reader) {
    final version = reader.readByte();

    switch (version) {
      case 1:
        return _readV1(reader);
      default:
        throw HiveError("error");
    }
  }

  PlayerModel _readV1(BinaryReader reader) {
    return PlayerModel(
      id: reader.readString(),
      firebaseID: reader.readString(),
      username: reader.readString(),
      lvl: reader.readInt(),
      avatarID: reader.readString(),
      createdAt: Timestamp.fromMillisecondsSinceEpoch(reader.readInt()),
      lastSeen: Timestamp.fromMillisecondsSinceEpoch(reader.readInt()),
      currentSessionId: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayerModel obj) {
    writer.writeByte(currentVersion);
    writer.writeString(obj.id);
    writer.writeString(obj.firebaseID);
    writer.writeString(obj.username);
    writer.writeInt(obj.lvl);
    writer.writeString(obj.avatarID);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeInt(obj.lastSeen.millisecondsSinceEpoch);
    writer.writeString(obj.currentSessionId ?? '');
  }
}
