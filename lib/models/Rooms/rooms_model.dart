import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_duel/extensions/game_status_extension.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';

class RoomModel {
  final String roomId;
  final String roomName;
  final String hostId;
  final int maxPlayers;
  final int playersCount;
  final GameStatus status;
  final String currentTurnPlayerId;
  final String winnerId;
  final bool isPrivate;
  final Map secretnumbers;
  final Timestamp createdAt;

  RoomModel({
    required this.roomName,
    required this.roomId,
    required this.hostId,
    required this.maxPlayers,
    required this.status,
    required this.createdAt,
    required this.playersCount,
    required this.currentTurnPlayerId,
    required this.winnerId,
    required this.secretnumbers,
    required this.isPrivate,
  });

  factory RoomModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    if (data == null) {
      throw Exception("Room data is null!");
    }

    return RoomModel(
      roomName: data['roomName'] ?? "Global",
      roomId: data['roomId'] ?? snapshot.id,
      hostId: data['hostId'] ?? '',

      playersCount: data['playersCount'] ?? 1,
      maxPlayers: data['maxPlayers'] ?? 2,
      status: GameStatusExtension.fromFirestore(data['status'] ?? 'waiting'),

      createdAt: data['createdAt'] as Timestamp? ?? Timestamp.now(),
      currentTurnPlayerId:
          data['currentTurnPlayerId'] ??
          FirebaseService.getCurrentUserFirebaseID(),
      winnerId: data["winner_id"] ?? '',
      secretnumbers: data["secret_numbers"] ?? {},
      isPrivate: data['isPrivate'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "playersCount": playersCount,
      "roomName": roomName,
      "roomId": roomId,
      "hostId": hostId,
      "currentTurnPlayerId": currentTurnPlayerId,
      "winner_id": winnerId,
      "maxPlayers": maxPlayers,
      "status": status.toFirestore(),
      "secret_numbers": secretnumbers,
      'isPrivate': isPrivate,
    };
  }
}
