import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';

class GameHistoryModel {
  final DateTime dateTime;
  final String gameId;
  final String secretCode;
  final List<AttemptModel> attemptsModel;
  final bool isWin;
  final List<String> players;
  final OfflineGameModel? offlineGameModel;

  GameHistoryModel({
    required this.dateTime,
    required this.gameId,
    required this.attemptsModel,
    required this.isWin,
    required this.players,
    this.offlineGameModel,
    required this.secretCode,
  });

  GameHistoryModel copyWith({
    DateTime? dateTime,
    String? gameId,
    List<AttemptModel>? attemptsModel,
    bool? isWin,
    List<String>? players,
    OfflineGameModel? offlineGameModel,
    String? secretCode,
  }) {
    return GameHistoryModel(
      dateTime: dateTime ?? this.dateTime,
      gameId: gameId ?? this.gameId,
      attemptsModel: attemptsModel ?? this.attemptsModel,
      isWin: isWin ?? this.isWin,
      players: players ?? this.players,
      offlineGameModel: offlineGameModel ?? this.offlineGameModel,
      secretCode: secretCode ?? this.secretCode,
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
