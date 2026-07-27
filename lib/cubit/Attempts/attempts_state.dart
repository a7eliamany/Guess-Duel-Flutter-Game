import 'package:guess_duel/models/Attempts/attempts_model.dart';

abstract class AttemptsState {}

class AttemptsInitial extends AttemptsState {}

class AttemptsLoading extends AttemptsState {}

class AttemptsLoaded extends AttemptsState {
  final List<AttemptModel> attempts;

  AttemptsLoaded({required this.attempts});
}

class AttemptsFailure extends AttemptsState {
  final String errorMsg;

  AttemptsFailure({required this.errorMsg});
}
