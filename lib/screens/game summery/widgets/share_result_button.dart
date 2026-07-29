import 'package:flutter/material.dart';

import 'package:guess_duel/Widgets/gradient_button.dart';

class ShareResultButton extends StatelessWidget {
  const ShareResultButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      color: const Color(0xFF0E0E0E),
      child: SafeArea(
        top: false,
        child: SizedBox(width: double.infinity, height: 56, child: test()),
      ),
    );
  }
}

Widget test() {
  return GradientButton(
    text: "Share Result",
    gradientColors: [
      Colors.white,
      const Color.fromARGB(255, 47, 198, 178),
      const Color.fromARGB(255, 21, 45, 177),
    ],
    icon: Icons.share,
    onPressed: () {},
  );
}
