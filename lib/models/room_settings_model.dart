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

  static RoundTime fromInt(int roundTime) {
    switch (roundTime) {
      case 15:
        return RoundTime.s15;
      case 30:
        return RoundTime.s30;
      case 45:
        return RoundTime.s45;
      case 60:
        return RoundTime.s60;
      default:
        return RoundTime.s45;
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

  factory RoomSettingsModel.fromFirestore(Map<String, dynamic> data) {
    return RoomSettingsModel(
      roomName: data['roomName'] ?? 'global',
      roomID: data['roomID'],
      roomPassword: data['roomPassword'] ?? '',
      isPrivate: data['isPrivate'] ?? false,
      roundTime: RoundTimeToInt.fromInt(data['roundTime'] ?? 45),
    );
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
