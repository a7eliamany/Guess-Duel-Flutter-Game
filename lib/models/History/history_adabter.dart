import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HistoryAdabter extends TypeAdapter<GameHistoryModel> {
  @override
  int get typeId => 3;
  final int currentVersion = 1;

  @override
  GameHistoryModel read(BinaryReader reader) {
    final version = reader.readByte();
    switch (version) {
      case 1:
        return _readV1(reader);

      default:
        throw HiveError("Error");
    }
  }

  GameHistoryModel _readV1(BinaryReader reader) {
    return GameHistoryModel(
      createdAt: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      gameId: reader.readString(),
      attemptsModel: reader.readList().cast<AttemptModel>(),
      isWin: reader.readBool(),
      offlineGameModel: reader.read(),
      secretCode: reader.readString(),
      playermodels: reader.readList().cast<PlayerModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, GameHistoryModel obj) {
    writer.writeByte(currentVersion);
    writer.writeInt(obj.createdAt.millisecondsSinceEpoch);
    writer.writeString(obj.gameId);
    writer.writeList(obj.attemptsModel);
    writer.writeBool(obj.isWin);
    writer.write(obj.offlineGameModel);
    writer.writeString(obj.secretCode);
    writer.writeList(obj.playermodels);
  }
}

class StatsAdapter extends TypeAdapter<StatsModel> {
  @override
  int get typeId => 4;

  final int currentVersion = 1;

  @override
  StatsModel read(BinaryReader reader) {
    final version = reader.readByte();
    switch (version) {
      case 1:
        return _readV1(reader);
      default:
        throw HiveError("Error");
    }
  }

  StatsModel _readV1(BinaryReader reader) {
    return StatsModel(
      gamesPlayed: reader.readInt(),
      wins: reader.readInt(),
      bestWinStreak: reader.readInt(),
      winStreak: reader.readInt(),
      experiences: reader.readInt(),
      recentGames: reader.readMap().cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, StatsModel obj) {
    writer.writeByte(currentVersion);
    writer.writeInt(obj.gamesPlayed);
    writer.writeInt(obj.wins);
    writer.writeInt(obj.bestWinStreak);
    writer.writeInt(obj.winStreak);
    writer.writeInt(obj.experiences);
    writer.writeMap(obj.recentGames);
  }
}
