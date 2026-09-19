class GameUtils {
  // static Map<String, int> checkAttempt({
  //   required String secretNumber,
  //   required String playerAttempt,
  // }) {
  //   int correctNumbers = 0;
  //   int correctPlaces = 0;

  //   for (int i = 0; i < secretNumber.length; i++) {
  //     if (playerAttempt[i] == secretNumber[i]) {
  //       correctPlaces++;
  //     }

  //     if (secretNumber.contains(playerAttempt[i])) {
  //       correctNumbers++;
  //     }
  //   }

  //   return {"correctNumbers": correctNumbers, "correctPlaces": correctPlaces};
  // }
  static Map<String, int> checkAttempt({
    required String secretNumber,
    required String playerAttempt,
  }) {
    int correctNumbers = 0;
    int correctPlaces = 0;

    // Count how many times each number appears in the secret.
    final Map<String, int> secretCounts = {};

    for (final digit in secretNumber.split('')) {
      secretCounts[digit] = (secretCounts[digit] ?? 0) + 1;
    }

    // Count how many times each number appears in the attempt.
    final Map<String, int> attemptCounts = {};

    for (final digit in playerAttempt.split('')) {
      attemptCounts[digit] = (attemptCounts[digit] ?? 0) + 1;
    }

    // Correct Numbers:
    // A number is correct as many times as it appears
    // in BOTH the secret and the attempt.
    for (final entry in attemptCounts.entries) {
      final digit = entry.key;
      final attemptCount = entry.value;
      final secretCount = secretCounts[digit] ?? 0;

      correctNumbers += attemptCount < secretCount ? attemptCount : secretCount;
    }

    // Correct Places:
    // Check exact position matches.
    for (int i = 0; i < secretNumber.length; i++) {
      if (secretNumber[i] == playerAttempt[i]) {
        correctPlaces++;
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
