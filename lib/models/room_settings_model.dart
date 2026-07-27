// enum RoomType { global, private }

enum RoundTime { s15, s30, s45, s60 }

extension RoundTimeToInt on RoundTime {
  int? toInt() {
    switch (this) {
      case RoundTime.s15:
        return 15;
      case RoundTime.s30:
        return 30;
      case RoundTime.s45:
        return 45;
      case RoundTime.s60:
        return 60;
    }
  }
}

class RoomSettingsModel {
  final String? roomName;
  final String? roomID;
  final String? roomPassword;
  final bool? isPrivate;
  final RoundTime? roundTime;

  RoomSettingsModel({
    this.roomID,
    this.roomName,
    this.roomPassword,
    this.isPrivate,
    this.roundTime,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'roomName': roomName ?? 'global',
      'roomID': roomID,
      'roomPassword': roomPassword ?? '',
      'isPrivate': isPrivate ?? false,
      'roundTime': roundTime?.toInt() ?? RoundTime.s45.toInt(),
    };
  }

  RoomSettingsModel copyWith({
    String? roomName,
    String? roomID,
    String? roomPassword,
    bool? isPrivate,
    RoundTime? roundTime,
  }) {
    return RoomSettingsModel(
      roomName: roomName ?? this.roomName,
      roomID: roomID ?? this.roomID,
      roomPassword: roomPassword ?? this.roomPassword,
      isPrivate: isPrivate ?? this.isPrivate,
      roundTime: roundTime ?? this.roundTime,
    );
  }
}
