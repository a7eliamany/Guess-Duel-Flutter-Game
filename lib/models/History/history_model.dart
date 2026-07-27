import 'package:guess_duel/models/Attempts/attempts_model.dart';

class GameHistoryModel {
  final DateTime dateTime;
  final String roomID;
  final List<AttemptModel> attemptsModel;
  final bool isWin;
  final List<String> players;

  GameHistoryModel({
    required this.dateTime,
    required this.roomID,
    required this.attemptsModel,
    required this.isWin,
    required this.players,
  });

  GameHistoryModel copyWith({
    DateTime? dateTime,
    String? roomID,
    List<AttemptModel>? attemptsModel,
    bool? isWin,
    List<String>? players,
  }) {
    return GameHistoryModel(
      dateTime: dateTime ?? this.dateTime,
      roomID: roomID ?? this.roomID,
      attemptsModel: attemptsModel ?? this.attemptsModel,
      isWin: isWin ?? this.isWin,
      players: players ?? this.players,
    );
  }
}

class StatsModel {
  final int gamesPlayed;
  final int wins;
  String get winRate => ((wins / gamesPlayed) * 100).toStringAsFixed(1);
  StatsModel({this.gamesPlayed = 0, this.wins = 0});

  StatsModel copyWith({int? gamesPlayed, int? wins}) {
    return StatsModel(
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      wins: wins ?? this.wins,
    );
  }
}
