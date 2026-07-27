import 'package:guess_duel/models/History/history_model.dart';

class HistortyState {}

class HistortyInitial extends HistortyState {}

class HistoryLoading extends HistortyState {}

class HistortyLoaded extends HistortyState {
  final List<GameHistoryModel> history;
  final StatsModel status;
  HistortyLoaded({required this.history, required this.status});
}

class HistortyError extends HistortyState {
  final String error;
  HistortyError({required this.error});
}
