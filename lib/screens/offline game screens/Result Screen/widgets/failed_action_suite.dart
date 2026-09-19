import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:guess_duel/Widgets/gradient_button.dart';
import 'package:remixicon/remixicon.dart';

class ResultActionSuite extends StatelessWidget {
  final VoidCallback? onRetryPressed;

  final VoidCallback? onModifyDifficultyPressed;

  const ResultActionSuite({
    super.key,
    this.onRetryPressed,
    this.onModifyDifficultyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Back Button
        GradientButton(
          text: "SEE ATTEMPTS",
          gradientColors: const [
            Color(0xFFDAB9FF),
            Color.fromARGB(255, 184, 42, 63),
            Color.fromARGB(255, 184, 42, 63),
          ],
          icon: Icons.arrow_forward,
          onPressed: () => Get.back(),
        ),

        const SizedBox(height: 12),

        // Initiate Retry Button
        GradientButton(
          text: "RETRY",
          gradientColors: const [
            Color(0xFFDAB9FF),
            Colors.blueGrey,
            Colors.blueGrey,
          ],
          icon: Icons.refresh,
          onPressed: onRetryPressed ?? () {},
        ),

        const SizedBox(height: 12),

        // Modify Difficulty Button
        GradientButton(
          text: "MODIFY DIFFICULTY",
          gradientColors: [
            const Color(0xFFDAB9FF),
            Colors.brown.shade800,

            Colors.brown.shade800,
          ],
          icon: RemixIcons.edit_2_fill,
          onPressed: onModifyDifficultyPressed ?? () {},
        ),
      ],
    );
  }
}
