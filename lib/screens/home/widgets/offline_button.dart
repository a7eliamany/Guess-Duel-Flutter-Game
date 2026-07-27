import 'package:flutter/material.dart';

import 'package:guess_duel/Widgets/glow_button.dart';
import 'package:guess_duel/screens/offline%20game%20screens/create_offline_game/offline_create_bs.dart';
import 'package:remixicon/remixicon.dart';

class OfflineButton extends StatelessWidget {
  const OfflineButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GlowButton(
      textColor: Theme.of(context).colorScheme.onSecondary,
      text: "PLAY OFFLINE",
      isEnabled: true,
      color: Colors.pink,
      onPressed: () {
        OfflineCreateBs.show(context);
      },
      icon: RemixIcons.wifi_off_line,
    );

    //  AnimatedButton(
    //   pressEvent: () {
    //     OfflineCreateBs.show(context);
    //   },
    //   color: Theme.of(context).colorScheme.tertiary,
    //   text: "Play Offline",
    //   buttonTextStyle: GoogleFonts.manrope(
    //     color: Theme.of(context).colorScheme.onTertiary,
    //     fontWeight: FontWeight.bold,
    //     fontSize: 16,
    //   ),
    // );
  }
}
