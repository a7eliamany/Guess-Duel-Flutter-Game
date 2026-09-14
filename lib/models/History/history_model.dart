import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';

class GameHistoryModel {
  final DateTime createdAt;
  final String gameId;
  final String secretCode;
  final List<AttemptModel> attemptsModel;
  final bool isWin;
  final List<String> players;
  final OfflineGameModel? offlineGameModel;

  GameHistoryModel({
    required this.createdAt,
    required this.gameId,
    required this.attemptsModel,
    required this.isWin,
    required this.players,
    this.offlineGameModel,
    required this.secretCode,
  });

  GameHistoryModel copyWith({
    DateTime? createdAt,
    String? gameId,
    List<AttemptModel>? attemptsModel,
    bool? isWin,
    List<String>? players,
    OfflineGameModel? offlineGameModel,
    String? secretCode,
  }) {
    return GameHistoryModel(
      createdAt: createdAt ?? this.createdAt,
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
  final int experiences;
  final int gamesPlayed;
  final int wins;
  final int winStreak;
  final int bestWinStreak;

  String get winRate => ((wins / gamesPlayed) * 100).toStringAsFixed(1);
  int get losess => gamesPlayed - wins;
  int get currentLevel => (experiences / 200).floor();

  StatsModel({
    this.gamesPlayed = 0,
    this.wins = 0,
    this.experiences = 0,
    this.bestWinStreak = 0,
    this.winStreak = 0,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "experiences": experiences,
      "gamesPlayed": gamesPlayed,
      "wins": wins,
      "winStreak": winStreak,
      "bestWinStreak": bestWinStreak,
    };
  }

  factory StatsModel.fromFirestore(Map<String, dynamic> map) {
    return StatsModel(
      experiences: map["experiences"] ?? 0,
      gamesPlayed: map["gamesPlayed"] ?? 0,
      wins: map["wins"] ?? 0,
      winStreak: map["winStreak"] ?? 0,
      bestWinStreak: map["bestWinStreak"] ?? 0,
    );
  }

  StatsModel copyWith({
    int? gamesPlayed,
    int? wins,
    int? winStreak,
    int? bestWinStreak,
    int? experiences,
  }) {
    return StatsModel(
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      wins: wins ?? this.wins,
      winStreak: winStreak ?? this.winStreak,
      bestWinStreak: bestWinStreak ?? this.bestWinStreak,
      experiences: experiences ?? this.experiences,
    );
  }
}
