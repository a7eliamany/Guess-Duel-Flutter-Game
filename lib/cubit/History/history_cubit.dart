import 'package:get/get.dart';
import 'package:guess_duel/cubit/History/historty_state.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';
import 'package:guess_duel/models/History/history_model.dart';
import 'package:guess_duel/models/offline/offline_game_model.dart';
import 'package:guess_duel/services/Hive/hive_service.dart';
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
    OfflineGameModel? offlineGameModel,
  }) async {
    try {
      final StatsModel? oldStatsModel = HiveService.statsBox.get('Stats');

      StatsModel statsModel = oldStatsModel ?? StatsModel();

      final int newWins = isWin ? statsModel.wins + 1 : statsModel.wins;
      final int newGamesPlayed = statsModel.gamesPlayed + 1;
      statsModel = statsModel.copyWith(
        gamesPlayed: newGamesPlayed,
        wins: newWins,
      );
      await HiveService.statsBox.put('Stats', statsModel);

      final GameHistoryModel gameHistoryModel = GameHistoryModel(
        dateTime: DateTime.now(),
        gameId: roomID,
        attemptsModel: attempts,
        isWin: isWin,
        players: players,
        secretCode: secretCode,
        offlineGameModel: offlineGameModel,
      );

      await HiveService.gameHistoryBox.add(gameHistoryModel);
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
