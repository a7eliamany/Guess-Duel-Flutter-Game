enum GameStatus<String> { waiting, secretCode, playing, finished }

extension GameStatusExtension on GameStatus {
  String toFirestore() {
    return name;
  }

  static GameStatus fromFirestore(String value) {
    return GameStatus.values.firstWhere((e) {
      return e.name == value;
    }, orElse: () => GameStatus.waiting);
  }
}
