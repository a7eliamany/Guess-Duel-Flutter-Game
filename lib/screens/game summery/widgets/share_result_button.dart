import 'package:flutter/material.dart';
import 'package:guess_duel/Functions/share_game.dart';

import 'package:guess_duel/Widgets/gradient_button.dart';

import 'package:screenshot/screenshot.dart';

class ShareResultButton extends StatefulWidget {
  final ScreenshotController screenshotController;

  const ShareResultButton({super.key, required this.screenshotController});

  @override
  State<ShareResultButton> createState() => _ShareResultButtonState();
}

class _ShareResultButtonState extends State<ShareResultButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      color: const Color(0xFF0E0E0E),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: GradientButton(
            isLoading: isLoading,
            text: "Share Result",
            gradientColors: const [
              Colors.white,
              Color.fromARGB(255, 47, 198, 178),
              Color.fromARGB(255, 21, 45, 177),
            ],
            icon: Icons.share,
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              final imagePath = await ShareGame.captureImage(
                widget.screenshotController,
              );

              setState(() {
                isLoading = false;
              });
              if (imagePath != null) {
                await ShareGame.shareGame(imagePath);
              }
            },
          ),
        ),
      ),
    );
  }
}
