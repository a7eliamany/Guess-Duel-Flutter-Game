import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_duel/extensions/player_role_extension.dart';

class PlayerModel {
  final String username;
  final String firebaseID;
  final String id;
  final int lvl;

  final Timestamp lastSeen;
  final Timestamp createdAt;

  PlayerModel({
    required this.id,
    required this.lvl,
    required this.firebaseID,

    required this.username,
    required this.lastSeen,
    required this.createdAt,
  });

  factory PlayerModel.fromFirestore(Map<String, dynamic> data) {
    return PlayerModel(
      firebaseID: data['firebaseID'] ?? '',
      id: data['id'] ?? '',
      lvl: data['lvl'] ?? 0,

      username: data['username'] ?? '',
      lastSeen: data['lastSeen'] ?? Timestamp.now(),
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'lvl': lvl,
      'firebaseID': firebaseID,

      'username': username,
      'createdAt': createdAt,
      'lastSeen': lastSeen,
    };
  }
}

class RoomPlayer {
  final PlayerModel playerModel;
  final PlayerRole playerRole;
  final RoomPlayerStatus roomPlayerStatus;
  final String? secretCode;

  RoomPlayer({
    required this.playerModel,
    required this.playerRole,
    required this.roomPlayerStatus,
    this.secretCode,
  });

  factory RoomPlayer.fromFirestore(Map<String, dynamic> playerModeldata) {
    return RoomPlayer(
      secretCode: playerModeldata['secretCode'] ?? "",
      roomPlayerStatus: RoomPlayerStatusExtension.fromFireStore(
        playerModeldata["RoomPlayerStatus"] ?? "ready",
      ),
      playerModel: PlayerModel.fromFirestore(playerModeldata),
      playerRole: PlayerRoleExtension.fromFirestore(
        playerModeldata["playerRole"],
      ),
    );
  }

  Map<String, dynamic> toFirestore() {
    final base = playerModel.toFirestore();
    base["playerRole"] = playerRole.toFirestore();
    base["RoomPlayerStatus"] = roomPlayerStatus.toFireStore();
    base['secretCode'] = secretCode ?? "";

    return base;
  }
}
