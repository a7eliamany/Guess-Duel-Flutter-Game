import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:guess_duel/cubit/History/historty_state.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:guess_duel/services/Firebase/firebase_service.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
import 'package:guess_duel/services/SharedPrefrences/shared_prefrences_service.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

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
    required List<String> players,
    required String secretCode,
    required bool isOffline,
    OfflineGameModel? offlineGameModel,
  }) async {
    try {
      final StatsModel? oldStatsModel = HiveService.statsBox.get('Stats');

      StatsModel statsModel = oldStatsModel ?? StatsModel();

      final int newWins = isWin ? statsModel.wins + 1 : statsModel.wins;
      final int newStreak = isWin ? statsModel.winStreak + 1 : 0;
      final int bestStreak = newStreak > statsModel.bestWinStreak
          ? newStreak
          : statsModel.bestWinStreak;
      final int newExperiences = statsModel.experiences + (isWin ? 200 : 50);
      final int newGamesPlayed = statsModel.gamesPlayed + 1;
      statsModel = statsModel.copyWith(
        gamesPlayed: newGamesPlayed,
        wins: newWins,
        winStreak: newStreak,
        bestWinStreak: bestStreak,
        experiences: newExperiences,
      );
      await HiveService.statsBox.put('Stats', statsModel);

      final GameHistoryModel gameHistoryModel = GameHistoryModel(
        createdAt: DateTime.now(),
        gameId: roomID,
        attemptsModel: attempts,
        isWin: isWin,
        players: players,
        secretCode: secretCode,
        offlineGameModel: offlineGameModel,
      );

      await HiveService.gameHistoryBox.add(gameHistoryModel);

      //add to recent game history (last 15 games)

      if (HiveService.recentGameHistoryBox.length >= 15) {
        await HiveService.recentGameHistoryBox.deleteAt(0);
      }
      await HiveService.recentGameHistoryBox.add(gameHistoryModel);

      // sync with firebase if online

      if (!isOffline) {
        await FirebaseFirestore.instance
            .collection(FirebaseCollections.players)
            .doc(SharedPrefService.getId())
            .collection(FirebaseCollections.stats)
            .doc(SharedPrefService.getId())
            .update(statsModel.toFirestore());
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
