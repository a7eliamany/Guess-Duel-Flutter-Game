import 'package:equatable/equatable.dart';
import 'package:guess_duel/models/Attempts/attempts_model.dart';

class OfflineGameModel extends Equatable {
  final String id;
  final DifficultyLevel difficultyLevel;
  final int digits;
  final int maxAttempts;
  final int usedAttmeps;
  final TimerType duration;
  final int timeElapsed;
  final bool allowRepeatedDigits;
  final String secretCode;
  final List<AttemptModel>? history;

  const OfflineGameModel({
    this.difficultyLevel = DifficultyLevel.normal,
    this.digits = 4,

    this.duration = TimerType.unlimited,
    this.allowRepeatedDigits = false,
    this.secretCode = '1234',
    this.history = const [],
    this.id = '',
    this.maxAttempts = 10,
    this.usedAttmeps = 0,
    this.timeElapsed = 0,
  });

  OfflineGameModel copyWith({
    DifficultyLevel? difficultyLevel,
    int? digits,
    TimerType? duration,
    bool? allowRepeatedDigits,
    String? secretCode,
    List<AttemptModel>? history,
    String? id,
    int? maxAttempts,
    int? usedAttmeps,
    int? timeElapsed,
  }) {
    return OfflineGameModel(
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      digits: digits ?? this.digits,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      duration: duration ?? this.duration,
      allowRepeatedDigits: allowRepeatedDigits ?? this.allowRepeatedDigits,
      secretCode: secretCode ?? this.secretCode,
      history: history ?? this.history,
      id: id ?? this.id,
      usedAttmeps: usedAttmeps ?? this.usedAttmeps,
      timeElapsed: timeElapsed ?? this.timeElapsed,
    );
  }

  @override
  List<Object?> get props => [
    difficultyLevel,
    digits,

    duration,
    allowRepeatedDigits,
    secretCode,
    history,
    id,
    maxAttempts,
    usedAttmeps,
    timeElapsed,
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

  TimerType fromSecs(int secs) {
    return TimerType.values.firstWhere((e) => e.timeInSecs == secs);
  }

  static TimerType fromName(String name) {
    return TimerType.values.firstWhere((e) => e.label == name);
  }
}
