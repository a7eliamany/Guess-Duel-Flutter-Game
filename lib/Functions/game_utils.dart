class GameUtils {
  static Map<String, int> checkAttempt({
    required String secretNumber,
    required String playerAttempt,
  }) {
    int correctNumbers = 0;
    int correctPlaces = 0;

    for (int i = 0; i < secretNumber.length; i++) {
      if (playerAttempt[i] == secretNumber[i]) {
        correctPlaces++;
      }

      if (secretNumber.contains(playerAttempt[i])) {
        correctNumbers++;
      }
    }

    return {"correctNumbers": correctNumbers, "correctPlaces": correctPlaces};
  }

  static String getTime(int secs) {
    int minutes = secs ~/ 60;
    int seconds = secs % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}

extension CheckAttemptEx on String {
  Map<String, int> checkAttempt({required String secretNumber}) {
    return GameUtils.checkAttempt(
      secretNumber: secretNumber,
      playerAttempt: this,
    );
  }
}
