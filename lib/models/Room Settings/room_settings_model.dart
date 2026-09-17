// enum RoomType { global, private }

enum RoundTime { s30, s45, s60, s75, s90 }

extension RoundTimeToInt on RoundTime {
  int? toInt() {
    switch (this) {
      case RoundTime.s30:
        return 30;
      case RoundTime.s45:
        return 45;
      case RoundTime.s60:
        return 60;
      case RoundTime.s75:
        return 75;
      case RoundTime.s90:
        return 90;
    }
  }

  static RoundTime fromInt(int roundTime) {
    switch (roundTime) {
      case 30:
        return RoundTime.s30;
      case 45:
        return RoundTime.s45;
      case 60:
        return RoundTime.s60;
      case 75:
        return RoundTime.s75;
      case 90:
        return RoundTime.s90;
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
  final bool? isTimeEnabled;
  final RoundTime? roundTime;

  RoomSettingsModel({
    this.roomID,
    this.roomName,
    this.roomPassword,
    this.isPrivate = false,
    this.roundTime = RoundTime.s30,
    this.isTimeEnabled = false,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'roomName': roomName ?? 'global',
      'roomID': roomID,
      'roomPassword': roomPassword ?? '',
      'isPrivate': isPrivate ?? false,
      'isTimeEnabled': isTimeEnabled ?? false,
      'roundTime': roundTime?.toInt() ?? RoundTime.s45.toInt(),
    };
  }

  factory RoomSettingsModel.fromFirestore(Map<String, dynamic> data) {
    return RoomSettingsModel(
      roomName: data['roomName'] ?? 'global',
      roomID: data['roomID'],
      roomPassword: data['roomPassword'] ?? '',
      isPrivate: data['isPrivate'] ?? false,
      isTimeEnabled: data['isTimeEnabled'] ?? false,
      roundTime: RoundTimeToInt.fromInt(data['roundTime'] ?? 45),
    );
  }

  RoomSettingsModel copyWith({
    String? roomName,
    String? roomID,
    String? roomPassword,
    bool? isPrivate,
    bool? isTimeEnabled,
    RoundTime? roundTime,
  }) {
    return RoomSettingsModel(
      roomName: roomName ?? this.roomName,
      roomID: roomID ?? this.roomID,
      roomPassword: roomPassword ?? this.roomPassword,
      isPrivate: isPrivate ?? this.isPrivate,
      isTimeEnabled: isTimeEnabled ?? this.isTimeEnabled,
      roundTime: roundTime ?? this.roundTime,
    );
  }
}
