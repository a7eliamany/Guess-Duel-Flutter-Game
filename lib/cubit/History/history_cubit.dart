import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:guess_duel/cubit/History/historty_state.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/models/Players/players_model.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';

class HistoryCubit extends Cubit<HistortyState> {
  HistoryCubit() : super(HistortyInitial());

  Future<void> getHistory() async {
    emit(HistoryLoading());
    try {
      await Future.delayed(500.milliseconds);
      final StatsModel? statsModel = HiveService.statsBox.get("Stats");

      final List<GameHistoryModel> history = HiveService.gameHistoryBox.values
          .toList()
          .cast<GameHistoryModel>();

      emit(
        HistortyLoaded(history: history, status: statsModel ?? StatsModel()),
      );
    } catch (e) {
      emit(HistortyError(error: e.toString()));
    }
  }

  Future<void> addToHistory({
    required String roomID,
    required List<AttemptModel> attempts,
    required bool isWin,
    required String secretCode,
    required bool isOffline,
    OfflineGameModel? offlineGameModel,
    required List<PlayerModel> playersmodels,
  }) async {
    try {
      // handle player stats
      final StatsModel? oldStatsModel = HiveService.statsBox.get('Stats');

      StatsModel statsModel = oldStatsModel ?? StatsModel();
      final int oldRecentGames = statsModel.recentGames['recent games'];
      final int oldRecentWins = statsModel.recentGames['wins'];

      final int newWins = isWin ? statsModel.wins + 1 : statsModel.wins;
      final int newStreak = isWin ? statsModel.winStreak + 1 : 0;
      final int bestStreak = newStreak > statsModel.bestWinStreak
          ? newStreak
          : statsModel.bestWinStreak;
      final int newExperiences = isOffline
          ? statsModel.experiences
          : statsModel.experiences + (isWin ? 200 : 50);
      final int newRecentGames = (oldRecentGames + 1) > 15
          ? 15
          : (oldRecentGames + 1);
      final int newRecentWins = isWin
          ? (oldRecentWins + 1 > 15)
                ? 15
                : (oldRecentWins + 1)
          : oldRecentWins;
      final int newRecentLosses = (newRecentGames - newRecentWins);

      // i need only last 15 games
      final Map<String, dynamic> recentgames = {
        "recent games": newRecentGames,
        'wins': newRecentWins,
        'losses': newRecentLosses,
      };
      statsModel = statsModel.copyWith(
        gamesPlayed: statsModel.gamesPlayed + 1,
        wins: newWins,
        winStreak: newStreak,
        bestWinStreak: bestStreak,
        experiences: newExperiences,
        recentGames: recentgames,
      );
      await HiveService.statsBox.put('Stats', statsModel);

      // handle game history

      final GameHistoryModel gameHistoryModel = GameHistoryModel(
        createdAt: DateTime.now(),
        gameId: roomID,
        attemptsModel: attempts,
        isWin: isWin,
        secretCode: secretCode,
        offlineGameModel: offlineGameModel,
        playermodels: playersmodels,
      );

      //add to recent game history (last 15 games) (test)

      await HiveService.gameHistoryBox.add(gameHistoryModel);

      if (HiveService.recentGameHistoryBox.length >= 15) {
        await HiveService.recentGameHistoryBox.deleteAt(0);
      }
      await HiveService.recentGameHistoryBox.add(gameHistoryModel);

      // sync with firebase if online and signed in

      if (FirebaseService.isUserSignedIn()) {
        final String? firebaseID = FirebaseAuth.instance.currentUser?.uid;
        await FirebaseFirestore.instance
            .collection(FirebaseCollections.players)
            .doc(firebaseID)
            .collection(FirebaseCollections.stats)
            .doc(firebaseID)
            .set(statsModel.toFirestore());
      }
    } catch (e) {
      emit(HistortyError(error: e.toString()));
    }
  }

  Future<void> clearGameHistory() async {
    emit(HistoryLoading());
    try {
      final StatsModel? oldStatsModel = HiveService.statsBox.get('Stats');

      StatsModel statsModel = oldStatsModel ?? StatsModel();

      await HiveService.gameHistoryBox.clear();
      emit(HistortyLoaded(history: [], status: statsModel));
    } catch (e) {
      emit(HistortyError(error: e.toString()));
    }
  }
}
