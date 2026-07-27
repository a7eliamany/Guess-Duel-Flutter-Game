enum PlayerRole<String> { host, player, spectator, idle }

enum RoomPlayerStatus<String> { ready, idle }

extension PlayerRoleExtension on PlayerRole {
  String toFirestore() {
    return name; // Dart 2.15+
  }

  static PlayerRole fromFirestore(String value) {
    return PlayerRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => PlayerRole.player,
    );
  }
}

extension RoomPlayerStatusExtension on RoomPlayerStatus {
  String toFireStore() {
    return name;
  }

  static RoomPlayerStatus fromFireStore(String value) {
    return RoomPlayerStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RoomPlayerStatus.idle,
    );
  }
}
