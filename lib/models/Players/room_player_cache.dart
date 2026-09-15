import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';
import 'package:guess_duel/models/Players/players_model.dart';

class RoomPlayerCache {
  final String id;
  final String firebaseID;
  final String username;
  final int lvl;
  final String avatarID;
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
    required this.avatarID,
    required this.id,
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
      avatarID: p.playerModel.avatarID,
      id: p.playerModel.id,
    );
  }

  static RoomPlayer toModel(RoomPlayerCache c) {
    return RoomPlayer(
      playerModel: PlayerModel(
        firebaseID: c.firebaseID,
        username: c.username,
        lvl: c.lvl,
        avatarID: c.avatarID,
        id: c.id,
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
      id: c.id,
      avatarID: c.avatarID,
      lastSeen: Timestamp.fromMillisecondsSinceEpoch(c.lastSeen),
      createdAt: Timestamp.fromMillisecondsSinceEpoch(c.createdAt),
    );
  }

  //copy with
  RoomPlayerCache copyWith({
    String? id,
    String? firebaseID,
    String? username,
    int? lvl,
    String? avatarID,
    String? playerRole,
    String? roomPlayerStatus,
    String? secretCode,
    int? lastSeen,
    int? createdAt,
  }) {
    return RoomPlayerCache(
      firebaseID: firebaseID ?? this.firebaseID,
      username: username ?? this.username,
      lvl: lvl ?? this.lvl,
      avatarID: avatarID ?? this.avatarID,
      playerRole: playerRole ?? this.playerRole,
      roomPlayerStatus: roomPlayerStatus ?? this.roomPlayerStatus,
      secretCode: secretCode ?? this.secretCode,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }
}
