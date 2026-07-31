import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/Players/players_model.dart';

class RoomPlayerCache {
  final String firebaseID;
  final String username;
  final int lvl;

  final String playerRole;
  final String roomPlayerStatus;
  final String? secretCode;
  final int lastSeen;
  final int createdAt;

  RoomPlayerCache({
    required this.firebaseID,
    required this.username,
    required this.lvl,

    required this.playerRole,
    required this.roomPlayerStatus,
    this.secretCode,
    required this.lastSeen,
    required this.createdAt,
  });

  factory RoomPlayerCache.fromModel(RoomPlayer p) {
    return RoomPlayerCache(
      firebaseID: p.playerModel.firebaseID,
      username: p.playerModel.username,
      lvl: p.playerModel.lvl,

      playerRole: p.playerRole.toFirestore(),
      roomPlayerStatus: p.roomPlayerStatus.toFireStore(),
      secretCode: p.secretCode,
      lastSeen: p.playerModel.lastSeen.millisecondsSinceEpoch,
      createdAt: p.playerModel.createdAt.millisecondsSinceEpoch,
    );
  }

  static RoomPlayer toModel(RoomPlayerCache c) {
    return RoomPlayer(
      playerModel: PlayerModel(
        firebaseID: c.firebaseID,
        username: c.username,
        lvl: c.lvl,

        id: c.firebaseID,
        lastSeen: Timestamp.fromMillisecondsSinceEpoch(c.lastSeen),
        createdAt: Timestamp.fromMillisecondsSinceEpoch(c.createdAt),
      ),
      playerRole: PlayerRoleExtension.fromFirestore(c.playerRole),
      roomPlayerStatus: RoomPlayerStatusExtension.fromFireStore(
        c.roomPlayerStatus,
      ),
      secretCode: c.secretCode,
    );
  }

  static PlayerModel toPlayerModel(RoomPlayerCache c) {
    return PlayerModel(
      firebaseID: c.firebaseID,
      username: c.username,
      lvl: c.lvl,
      id: c.firebaseID,
      lastSeen: Timestamp.fromMillisecondsSinceEpoch(c.lastSeen),
      createdAt: Timestamp.fromMillisecondsSinceEpoch(c.createdAt),
    );
  }
}
