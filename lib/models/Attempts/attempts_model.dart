import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AttemptModel extends Equatable {
  final String userId;
  final String attempt;
  final int correctNumbers;
  final int correctPlaces;
  final Timestamp? createdAt;

  const AttemptModel({
    required this.userId,
    required this.attempt,
    required this.correctNumbers,
    required this.correctPlaces,
    this.createdAt,
  });

  double get accuracy => (((correctNumbers + correctPlaces) / 4) * 100);

  factory AttemptModel.fromFirestore(Map<String, dynamic> data) {
    return AttemptModel(
      userId: data['userId'] ?? '',
      attempt: data['attempt'] ?? '',
      correctNumbers: data['correctNumbers'] ?? 0,
      correctPlaces: data['correctPlaces'] ?? 0,
      createdAt: data['createdAt'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "userId": userId,
      "attempt": attempt,
      "correctNumbers": correctNumbers,
      "correctPlaces": correctPlaces,
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  AttemptModel copyWith({
    String? userId,
    String? attempt,
    int? correctNumbers,
    int? correctPlaces,
    Timestamp? createdAt,
  }) {
    return AttemptModel(
      userId: userId ?? this.userId,
      attempt: attempt ?? this.attempt,
      correctNumbers: correctNumbers ?? this.correctNumbers,
      correctPlaces: correctPlaces ?? this.correctPlaces,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    userId,
    attempt,
    correctNumbers,
    correctPlaces,
    createdAt,
  ];
}

class AttemptCheck {
  final int correctNumbers;
  final int correctPlaces;

  AttemptCheck({required this.correctNumbers, required this.correctPlaces});

  factory AttemptCheck.fromMap(Map<String, dynamic> map) {
    return AttemptCheck(
      correctNumbers: map["correctNumbers"],
      correctPlaces: map['correctPlaces'],
    );
  }

  Map<String, dynamic> toMap() {
    return {"correctNumbers": correctNumbers, 'correctPlaces': correctPlaces};
  }
}
