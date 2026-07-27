import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AttemptsTypeAdabter extends TypeAdapter<AttemptModel> {
  @override
  int get typeId => 1;

  @override
  AttemptModel read(BinaryReader reader) {
    return AttemptModel(
      userId: reader.readString(),
      attempt: reader.readString(),
      correctNumbers: reader.readInt(),
      correctPlaces: reader.readInt(),
      createdAt: Timestamp.fromMillisecondsSinceEpoch(reader.readInt()),
    );
  }

  @override
  void write(BinaryWriter writer, AttemptModel obj) {
    writer.writeString(obj.userId);
    writer.writeString(obj.attempt);
    writer.writeInt(obj.correctNumbers);
    writer.writeInt(obj.correctPlaces);
    writer.writeInt(obj.createdAt!.millisecondsSinceEpoch);
  }
}
