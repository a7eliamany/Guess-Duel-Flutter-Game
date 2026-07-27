enum RoomFlow { waiting, filling, ready, opponentLeft }

class SecretNumberState {
  final String digits;
  final int currentIndex;
  final RoomFlow roomFlow;

  const SecretNumberState({
    required this.digits,
    required this.currentIndex,
    required this.roomFlow,
  });

  factory SecretNumberState.initial() {
    return const SecretNumberState(
      digits: '',
      currentIndex: 0,
      roomFlow: RoomFlow.filling,
    );
  }
  SecretNumberState copyWith({
    String? digits,
    int? currentIndex,
    RoomFlow? roomFlow,
  }) {
    return SecretNumberState(
      digits: digits ?? this.digits,
      currentIndex: currentIndex ?? this.currentIndex,
      roomFlow: roomFlow ?? this.roomFlow,
    );
  }
}
