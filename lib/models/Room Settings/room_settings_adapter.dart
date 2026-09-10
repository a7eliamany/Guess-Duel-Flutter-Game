import 'package:guess_duel/models/Room%20Settings/room_settings_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RoomSettingsAdapter extends TypeAdapter<RoomSettingsModel> {
  @override
  read(BinaryReader reader) {
    return RoomSettingsModel(
      isPrivate: reader.readBool(),
      isTimeEnabled: reader.readBool(),
      roomID: reader.readString(),
      roomName: reader.readString(),
      roomPassword: reader.readString(),
      roundTime: RoundTimeToInt.fromInt(reader.readInt()),
    );
  }

  @override
  int get typeId => 6;

  @override
  void write(BinaryWriter writer, obj) {
    writer.writeBool(obj.isPrivate ?? false);
    writer.writeBool(obj.isTimeEnabled ?? false);
    writer.writeString(obj.roomID ?? '');
    writer.writeString(obj.roomName ?? "");
    writer.writeString(obj.roomPassword ?? '');
    writer.writeInt(obj.roundTime?.toInt() ?? 30);
  }
}
