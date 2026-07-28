import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OfflineGameAdapter extends TypeAdapter<OfflineGameModel> {
  @override
  int get typeId => 5;

  @override
  OfflineGameModel read(BinaryReader reader) {
    return OfflineGameModel(
      id: reader.readString(),
      difficultyLevel: DifficultyLevel.values.byName(reader.readString()),
      allowRepeatedDigits: reader.readBool(),
      digits: reader.readInt(),
      maxAttempts: reader.readInt(),
      usedAttmeps: reader.readInt(),
      timeElapsed: reader.readInt(),
      duration: TimerType.values.byName(reader.readString()),
      secretCode: reader.readString(),
      history: reader.readList().cast<AttemptModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, OfflineGameModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.difficultyLevel.name);
    writer.writeBool(obj.allowRepeatedDigits);
    writer.writeInt(obj.digits);
    writer.writeInt(obj.maxAttempts);
    writer.writeInt(obj.usedAttmeps);
    writer.writeInt(obj.timeElapsed);
    writer.writeString(obj.duration.name);
    writer.writeString(obj.secretCode);
    writer.writeList(obj.history ?? []);
  }
}
