import 'dart:math';

class RandomF {
  static String getRandomPassword(int length) {
    const allChars = 'abcdefghijklmnopqrstuvwxyz0123456789@#!*';
    final random = Random();
    return List.generate(
      length,
      (index) => allChars[random.nextInt(allChars.length)],
    ).join();
  }

  static String getRandomEmail(String username, int length) {
    const chars = '0123456789';
    final random = Random();
    String randomString = List.generate(
      length,
      (index) => chars[random.nextInt(chars.length)],
    ).join();
    return "$username$randomString@gmail.com";
  }

  static String getRandomRoomID(int length) {
    const chars = 'ABCDEFGH';
    const String numbers = '0123456789';
    final Random random = Random();

    final String c = List.generate(
      2,
      (index) => chars[random.nextInt(chars.length)],
    ).join();

    final String n = List.generate(
      length - 2,
      (index) => numbers[random.nextInt(chars.length)],
    ).join();

    return "$c$n";
  }

  static String getUniqueUsername(int length) {
    const String capitalChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String smallChars = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';
    Random random = Random();
    const String all = capitalChars + smallChars + numbers;
    return List.generate(
      length,
      (index) => all[random.nextInt(all.length)],
    ).join();
  }

  static String getUniqueID(int length) {
    const String numbers = '0123456789';
    Random random = Random();
    return List.generate(
      length,
      (index) => numbers[random.nextInt(numbers.length)],
    ).join();
  }

  static String generateSecretCode(int length, bool isRepetedAllowed) {
    final random = Random();
    List<int> digits = [];
    for (int i = 0; i < length; i++) {
      int digit = random.nextInt(10);
      if (isRepetedAllowed) {
        digits.add(digit);
      } else {
        while (digits.contains(digit)) {
          digit = random.nextInt(10);
        }
        digits.add(digit);
      }
    }

    return digits.join();
  }
}
