import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class ShareGame {
  static Future<File?> captureImage(
    ScreenshotController screenshotController,
  ) async {
    final image = await screenshotController.capture();

    if (image == null) return null;

    final directory = await getTemporaryDirectory();

    final imagePath = File('${directory.path}/guess_duel.png');

    await imagePath.writeAsBytes(image);

    return imagePath;
  }

  static Future<void> shareGame(File imagePath) async {
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(imagePath.path)],
        text: "Check out my Result in Guess Duel!",
      ),
    );
  }
}
