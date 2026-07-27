import 'package:equatable/equatable.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';

class OfflineGameModel extends Equatable {
  final DifficultyLevel difficultyLevel;
  final int digits;
  final int attempts;
  final TimerType timer;
  final bool allowRepeatedDigits;
  final String secretCode;
  final List<AttemptModel>? history;

  const OfflineGameModel({
    this.difficultyLevel = DifficultyLevel.normal,
    this.digits = 4,
    this.attempts = 10,
    this.timer = TimerType.unlimited,
    this.allowRepeatedDigits = false,
    this.secretCode = '1234',
    this.history = const [],
  });

  OfflineGameModel copyWith({
    DifficultyLevel? difficultyLevel,
    int? digits,
    int? attempts,
    TimerType? timer,
    bool? allowRepeatedDigits,
    String? secretCode,
    List<AttemptModel>? history,
  }) {
    return OfflineGameModel(
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      digits: digits ?? this.digits,
      attempts: attempts ?? this.attempts,
      timer: timer ?? this.timer,
      allowRepeatedDigits: allowRepeatedDigits ?? this.allowRepeatedDigits,
      secretCode: secretCode ?? this.secretCode,
      history: history ?? this.history,
    );
  }

  @override
  List<Object?> get props => [
    difficultyLevel,
    digits,
    attempts,
    timer,
    allowRepeatedDigits,
    secretCode,
    history,
  ];
}

enum DifficultyLevel { easy, normal, hard, extreme, custom }

enum TimerType { unlimited, tenMinutes, fiveMinutes, threeMinutes, twoMinutes }

extension TimerTypeExtension on TimerType {
  String get label {
    switch (this) {
      case TimerType.unlimited:
        return 'Unlimited';
      case TimerType.tenMinutes:
        return '10 min';
      case TimerType.fiveMinutes:
        return '5 min';
      case TimerType.threeMinutes:
        return '3 min';
      case TimerType.twoMinutes:
        return '2 min';
    }
  }

  int get timeInSecs {
    switch (this) {
      case TimerType.unlimited:
        return 0;
      case TimerType.tenMinutes:
        return 10 * 60;
      case TimerType.fiveMinutes:
        return 5 * 60;
      case TimerType.threeMinutes:
        return 3 * 60;
      case TimerType.twoMinutes:
        return 2 * 60;
    }
  }

  static TimerType fromName(String name) {
    return TimerType.values.firstWhere((e) => e.label == name);
  }
}
